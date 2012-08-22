Chaplin = require 'chaplin'

Garbage = require 'core/Garbage'
View = require 'core/View'

ListView = require 'views/main/List'
FolderView = require 'views/main/Folder'

# The folder with other folders and lists.
module.exports = class FolderHolderView extends View

    container:       '#main'
    autoRender:      true
    containerMethod: 'html'

    initialize: ->
        super

        # The garbage truck... wroom!
        @views = new Garbage()

        # We are not re-rendering on change of the underlying `Folder` Model as otherwise when say dropping multiple `Lists`
        # on a `Folder`, we would re-render too quickly and have access to objects that no longer exist. Thus we need to
        # manually say to this `Folder` when to re-render after we have done operations on it.
        # @modelBind 'change', @render
        Chaplin.mediator.subscribe 'renderMain', @render

        # Listen to the inner lists being checked.
        Chaplin.mediator.subscribe 'checkedLists', @updateCheckbox

    # Get the template from here.
    getTemplateFunction: -> require 'templates/folder_objects'

    afterRender: ->
        super

        # Thrash the garbage.
        @undelegate()
        @views.dump()

        # Bind to the main checkbox.
        @delegate 'click', 'input.check-all', @checkAllLists

        # Update main checkbox according to whether all is checked or not.
        @updateCheckbox()

        # Render the lists.
        for model in @model.get 'lists'
            @views.push new ListView 'model': model
        
        # Render the folders.
        for model in @model.get 'folders'
            # Keep reference to us so that children can tell us when to draw ourselves pretty again...
            @views.push new FolderView 'model': model, parent: @

    # Need to dispose of us listening to channels.
    dispose: ->
        for channel in [ 'checkedLists', 'renderMain' ]
            Chaplin.mediator.unsubscribe channel

        super

    # Update main checkbox according to whether all is checked or not.
    updateCheckbox: =>
        [ nay, yay ] = @checked()

        $(@el).find('input.check-all').prop 'checked', nay is 0

    # Count the number of un-/checked lists on us.
    checked: =>
        r = [ 0, 0 ]
        for list in @model.get('lists')
            r[0 + list.get('checked')] += 1
        r

    # Un-/check all lists in this table.
    checkAllLists: ->
        [ nay, yay ] = @checked()

        # Which action are we going to do?
        which = true
        if nay is 0 then which = false

        # Quietly execute.
        for list in @model.get 'lists'
            list.set 'checked': which, { 'silent': true }

        # Say to others how many lists are checked.
        Chaplin.mediator.publish 'checkedLists', if which is true then yay + nay else 0

        # One re-render after all is done.
        @render()