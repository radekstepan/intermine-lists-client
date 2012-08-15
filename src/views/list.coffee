define [
    'core/view'
], (View) ->

    class ListView extends View

        container:       '#main table tbody'
        containerMethod: 'append'
        autoRender:      true

        tagName: -> if not @moving then 'tr' else 'div'

        # Is this list UI moving?
        moving: false

        # Get the template from here.
        getTemplateFunction: -> if not @moving then JST['list'] else JST['list_moving']

        initialize: ->
            super

            $(@el).draggable
                'start': @startDragging
                'stop':  @stopDragging
            $(@el).data 'view', @

        afterRender: ->
            super

            $(@el).addClass('list')

        # We have started to drag this list.
        startDragging: =>
            @moving = true
            @render()

        # This drug for too long...
        stopDragging: =>
            @moving = false
            @render()