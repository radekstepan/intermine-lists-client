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

            # Create a clone of yourself while being dragged.
            $(@el).draggable
                'helper': => (@clone = new ListMovingView('model': @model)).el

            # Make a reference to "us" through `data` although we use ListMovingView.
            $(@el).data 'view': @

        afterRender: ->
            super

            $(@el).addClass('list')