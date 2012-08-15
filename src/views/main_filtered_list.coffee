define [
    'core/garbage'
    'core/view'
    'views/list'
], (Garbage, View, ListView) ->

    # The filtered collection of lists.
    class MainFilteredListView extends View

        container:       '#main'
        autoRender:      true
        containerMethod: 'html'

        initialize: ->
            super

            # The garbage truck... wroom!
            @views = new Garbage()

        # Get the template from here.
        getTemplateFunction: -> JST['filtered_list']

        # Peek into the data to show msg according to the results.
        getTemplateData: -> 'length': @options.collection.models.length

        afterRender: ->
            super

            # Render the lists inside.
            for model in @options.collection.models
                @views.push view = new ListView 'model': model