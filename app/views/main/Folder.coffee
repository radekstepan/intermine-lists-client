Chaplin = require 'chaplin'

View = require 'core/View'

module.exports = class FolderView extends View

    container:       '#main table tbody'
    tagName:         'tr'
    containerMethod: 'append'
    autoRender:      true

    # Get the template from here.
    getTemplateFunction: -> require 'templates/folder'

    initialize: (options) ->
        super

        # Set the dad on us.
        @parent = options.parent

    afterRender: ->
        super

        $(@el).addClass 'folder'

        # Make droppable.
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

        # Get the data associated.
        lists = $(ui.draggable).data('collection')

        # The new path.
        newPath = @model.get('path')

        # Update all the lists that were passed in.
        lists.each (list) =>
            # The old path.
            oldPath = list.get('path')

            # Are the paths the same?
            if newPath isnt oldPath
                # Message about it.
                Chaplin.mediator.publish 'notification', "Has been moved from \"#{oldPath}\" to \"#{newPath}\"", list.get('name')

                # Update the list path itself.
                list.set 'path', newPath

                # Push the list on this folder.
                @model.addList list

        # We have done some actions on a folder in the `MainFolderView`, tell it that it needs to re-render itself.
        Chaplin.mediator.publish 'renderMain'