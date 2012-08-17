define [
    'core/view'
], (View) ->

    # Multiple lists being dragged around.
    class ListsMovingView extends View

        autoRender: true

        # Get the template from here.
        getTemplateFunction: -> JST['lists_moving']

        getTemplateData: -> 'size': @collection.length

        afterRender: ->
            super

            $(@el).addClass 'moving'