define [
    'chaplin'
    'core/garbage'
    'core/view'
    'views/filtered_list'
], (Chaplin, Garbage, View, FilteredListView) ->

    # The filtered collection of lists.
    class MainFilteredListView extends View

        container:       '#main'
        autoRender:      true
        containerMethod: 'html'

        initialize: ->
            super

            # The garbage truck... wroom!
            @views = new Garbage()

            # Re-render itself when others tell us to.
            Chaplin.mediator.subscribe 'renderMain', @render

        # Get the template from here.
        getTemplateFunction: -> JST['filtered_lists']

        # Peek into the data to show msg according to the results.
        getTemplateData: -> 'length': @collection.models.length

        afterRender: ->
            super

            # Thrash the garbage.
            @undelegate()
            @views.dump()

            # Render the lists inside.
            for model in @collection.models
                @views.push view = new FilteredListView 'model': model