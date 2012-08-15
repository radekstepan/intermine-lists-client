define [
    'core/view'
], (View) ->

    # A list that is being dragged around.
    class ListMovingView extends View

        autoRender: true

        # Get the template from here.
        getTemplateFunction: -> JST['list_moving']

        afterRender: ->
            $(@el).addClass 'moving'