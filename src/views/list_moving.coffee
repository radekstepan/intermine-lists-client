define [
    'core/view'
], (View) ->

    # A list being moved around.
    class ListMovingView extends View

        autoRender: true

        # Get the template from here.
        getTemplateFunction: -> JST['list_moving']

        afterRender: ->
            super

            $(@el).addClass 'moving'