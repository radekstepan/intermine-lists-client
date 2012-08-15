define [
    'core/view'
], (View) ->

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

        over: => $(@el).addClass 'hover'

        out: => $(@el).removeClass 'hover'