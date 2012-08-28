Chaplin = require 'chaplin'

Garbage = require 'core/Garbage'
View = require 'core/View'

module.exports = class OrganiseFolderView extends View

    tagName: 'li' # a list item

    toggleEl: undefined # points to the toggler element

    # Get the template from here.
    getTemplateFunction: -> require 'templates/organise_folder'

    # 'Serialize' our opts and add cid so we can constrain events.
    getTemplateData: -> _.extend { 'cid': @model.cid }, @model.toJSON()

    initialize: (opts) ->
        super

        # Set the selected on us so we can pass it further.
        @selected = opts.selected



        # Listen to folders being selected... then deselect us
        Chaplin.mediator.subscribe 'selectFolder', => $(@el).removeClass('active')

        # The garbage truck... wroom!
        @views = new Garbage()

    # Render the subviews.
    afterRender: ->
        super

        # Dispose of previous subviews and clean up events.
        @undelegate()
        @views.dump()

        # Events only on this folder.
        @delegate 'click', ".folder.#{@model.cid}.toggle", @toggleFolder

        # Re-render when we get expanded etc.
        @modelBind 'change', @render

        # Are we selecting this folder?
        @delegate 'click', ".select.#{@model.cid}", @selectFolder

        # Are we set as selected?
        if @model.get('selected') then $(@el).addClass('active')

        # Make a link to toggle element.
        @toggleEl = $(@el).find('.toggle')

        # Render the subviews.
        if @model.get('path') is '/' or @model.get('expanded')
            # Render our folders.
            for folder in @model.get 'folders'
                $(@el).find('ul.folders').first().append (v = new OrganiseFolderView('model': folder)).render().el
                @views.push v

        # If we have folders then show a toggler for this folder.
        if @model.get('folders').length isnt 0
            $(@el).find(".folder.#{@model.cid}.toggle").addClass do =>
                if @model.get 'expanded' then 'active icon-caret-down'
                else 'active icon-caret-right'

    # Toggle the folder, the view is listening to Model changes already.
    toggleFolder: -> @model.set 'expanded', !@model.get('expanded')

    selectFolder: ->
        # First we deselect any folder listening. We pass Model to listening OrganiseListsView
        Chaplin.mediator.publish 'selectFolder', @model
        # And then we select us.
        $(@el).addClass('active')