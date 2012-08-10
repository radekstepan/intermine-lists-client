define [
    'chaplin'
    'views/sidebar_list'
], (Chaplin, SidebarListView) ->

    class SidebarListsView extends Chaplin.CollectionView

        container:  'ul#folders'
        autoRender: true

        ###
        Instantiate an individual list View.
        @param {Object} item A model
        ###
        getView: (item) -> new SidebarListView 'model': item