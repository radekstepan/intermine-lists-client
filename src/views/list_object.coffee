define [
    'core/view'
], (View) ->

    class ListObjectView extends View

        container:       '#main table tbody'
        tagName:         'tr'
        containerMethod: 'append'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['list_object']

        getTemplateData: ->
            'values': ( value for _, value of @model.toJSON() )