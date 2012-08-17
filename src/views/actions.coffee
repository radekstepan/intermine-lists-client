define [
    'chaplin'
    'core/view'
], (Chaplin, View) ->

    class ActionsView extends View

        container:  '#actions'
        autoRender: true

        # Number of checked lists.
        checked: 0

        getTemplateFunction: -> JST['actions']

        getTemplateData: ->
            'checked': @checked

        initialize: ->
            super

            # Listen to lists being checked.
            Chaplin.mediator.subscribe 'checkedLists', @updateCheckedCount

        updateCheckedCount: (@checked) => @render()