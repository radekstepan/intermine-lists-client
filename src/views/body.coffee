define [
    'core/view'
], (View) ->

    class BodyView extends View

        container:       'body'
        containerMethod: 'html'
        autoRender:      true

        getTemplateFunction: -> JST['body']