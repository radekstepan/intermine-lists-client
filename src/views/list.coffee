define [
    'core/view'
    'views/list_moving'
], (View, ListMovingView) ->

    class ListView extends View

        container:       '#main table tbody'
        containerMethod: 'append'
        autoRender:      true
        tagName:         'tr'

        # Get the template from here.
        getTemplateFunction: -> JST['list']

        initialize: ->
            super

            $(@el).draggable
                'helper': @helper

        afterRender: ->
            super

            $(@el).addClass('list')

        # Create a clone of yourself while being dragged.
        helper: => (@clone = new ListMovingView('model': @model)).el