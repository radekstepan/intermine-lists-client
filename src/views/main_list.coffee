define [
    'core/garbage'
    'core/view'
    'views/list_object'
], (Garbage, View, ListObjectView) ->

    # The list and its contents.
    class MainListView extends View

        container:  '#main'
        autoRender: true

        initialize: ->
            super

            # The garbage truck... wroom!
            @views = new Garbage()

        # Get the template from here.
        getTemplateFunction: -> JST['list_objects']

        getTemplateData: ->
            # Render the table head peeking on the first object.
            'head': Object.keys @collection.models[0].toJSON()

        afterRender: ->
            super

            # Render the children.
            for model in @collection.models
                @views.push view = new ListObjectView 'model': model