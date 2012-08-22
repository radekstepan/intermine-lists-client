Chaplin = require 'chaplin'

Garbage = require 'core/Garbage'
View = require 'core/View'

FilteredListView = require 'views/main/FilteredList'

# The filtered collection of lists.
module.exports = class FilteredListHolderView extends View

    container:       '#main'
    autoRender:      true
    containerMethod: 'html'

    initialize: ->
        super

        # The garbage truck... wroom!
        @views = new Garbage()

        # Re-render itself when others tell us to.
        Chaplin.mediator.subscribe 'renderMain', @render

        # Listen to the inner lists being checked.
        Chaplin.mediator.subscribe 'checkedLists', @updateCheckbox

    # Get the template from here.
    getTemplateFunction: -> require 'templates/filtered_lists'

    # Peek into the data to show msg according to the results.
    getTemplateData: -> 'length': @collection.models.length

    afterRender: ->
        super

        # Thrash the garbage.
        @undelegate()
        @views.dump()

        # Bind to the main checkbox.
        @delegate 'click', 'input.check-all', @checkAllLists

        # Update main checkbox according to whether all is checked or not.
        @updateCheckbox()

        # Render the lists inside.
        for model in @collection.models
            @views.push view = new FilteredListView 'model': model

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
    checked: ->
        r = [ 0, 0 ]
        for list in @collection.models
            r[0 + list.get('checked')] += 1
        r

    # Un-/check all lists in this table.
    checkAllLists: ->
        [ nay, yay ] = @checked()

        # Which action are we going to do?
        which = true
        if nay is 0 then which = false

        # Quietly execute.
        for list in @collection.models
            list.set 'checked': which, { 'silent': true }

        # Say to others how many lists are checked.
        Chaplin.mediator.publish 'checkedLists', if which is true then yay + nay else 0

        # One re-render after all is done.
        @render()