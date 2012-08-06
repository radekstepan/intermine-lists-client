define [
    'chaplin'
    'views/folder_view'
], (Chaplin, FolderView) ->

    class FoldersView extends Chaplin.CollectionView

        containerMethod: 'append'
        container:       'ul#folders'
        autoRender:      true

        getView: (item) ->
            new FolderView 'model': item