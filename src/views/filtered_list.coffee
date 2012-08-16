define [
    'views/list'
    'views/list_moving'
], (ListView, ListMovingView) ->

    class FilteredListView extends ListView

        # Get the template from here.
        getTemplateFunction: -> JST['filtered_list']