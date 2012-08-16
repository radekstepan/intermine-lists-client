define [
    'chaplin'
    'core/garbage'
    'core/view'
    'views/sidebar_folder'
], (Chaplin, Garbage, View, SidebarListView, SidebarFolderView) ->

    class SidebarFolderView extends View

        tagName: 'li' # a list item

        toggleEl: undefined # points to the toggler element

        # Get the template from here.
        getTemplateFunction: -> JST['sidebar_folder']

        # 'Serialize' our opts and add cid so we can constrain events.
        getTemplateData: -> _.extend { 'cid': @model.cid }, @model.toJSON()

        initialize: ->
            super

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
            @modelBind 'change', @render

            # Are we selected?
            if @model.get('selected') then $(@el).addClass('active')

            # Make the folder droppable.
            $(@el).find('.drop:not(.ui-droppable)').droppable
                'over': @over
                'out':  @out
                'drop': @drop

            # Make a link to toggle element.
            @toggleEl = $(@el).find('.toggle')

            # Render the subviews.
            if @model.get('path') is '/' or @model.get('expanded')
                # Render our folders.
                for folder in @model.get 'folders'
                    $(@el).find('ul.folders').first().append (v = new SidebarFolderView('model': folder)).render().el
                    @views.push v

            # If we have folders then show a toggler for this folder.
            if @model.get('folders').length isnt 0
                $(@el).find(".folder.#{@model.cid}.toggle").addClass do =>
                    if @model.get 'expanded' then 'active icon-caret-down'
                    else 'active icon-caret-right'

        # Toggle the folder, the view is listening to Model changes already.
        toggleFolder: -> @model.set 'expanded', !@model.get('expanded')

        over: (e) =>
            $(e.target).addClass 'hover'
            @toggleEl.addClass 'hover'

        out: (e) =>
            $(e.target).removeClass 'hover'
            @toggleEl.removeClass 'hover'

        # A dragged list has been dropped on us.
        drop: (e, ui) =>
            # Remove the hover sign.
            $(e.target).removeClass 'hover'
            @toggleEl.removeClass 'hover'
            # Get the list associated.
            list = $(ui.draggable).data('view').model

            # The paths.
            newPath = @model.get('path') ; oldPath = list.get('path')

            # Message about it.
            Chaplin.mediator.publish 'notification', "Has been moved from \"#{oldPath}\" to \"#{newPath}\"", list.get('name')

            # Update the list path itself.
            list.set 'path', newPath

            # Push the list on this folder.
            @model.addList list