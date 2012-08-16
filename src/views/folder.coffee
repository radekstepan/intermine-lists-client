define [
    'chaplin'
    'core/view'
], (Chaplin, View) ->

    class FolderView extends View

        container:       '#main table tbody'
        tagName:         'tr'
        containerMethod: 'append'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['folder']

        afterRender: ->
            super

            $(@el).addClass 'folder'

        initialize: ->
            super

            $(@el).droppable
                'over': @over
                'out':  @out
                'drop': @drop

        over: => $(@el).addClass 'hover'

        out: => $(@el).removeClass 'hover'

        # A dragged list has been dropped on us.
        drop: (e, ui) =>
            # Remove the hover sign.
            $(@el).removeClass 'hover'
            # Get the list associated.
            list = $(ui.draggable).data('view').model

            # The paths.
            newPath = @model.get('path') ; oldPath = list.get('path')

            # Message about it.
            Chaplin.mediator.publish 'notification', "Has been moved from \"#{oldPath}\" to \"#{newPath}\"", list.get('name')

            # Update the list path itself.
            list.set 'path', newPath

            # Update the Folders collection in the store (automatically maybe?).