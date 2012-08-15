define [
    'core/view'
], (View) ->

    # The filtered collection of lists.
    class MainFilteredListView extends View

        containerMethod: 'html'
        container:       '#main'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['filtered_list']

        getTemplateData: -> 'lists': ( list.toJSON() for list in @options.collection.models )