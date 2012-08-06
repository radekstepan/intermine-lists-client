define [
    'chaplin'
    'models/folders'
    'views/folders_view'
], (Chaplin, Folders, FoldersView) ->

    class FoldersController extends Chaplin.Controller

        historyURL: (params) -> ''

        # List all documents.
        index: (params) ->
            collection = new Folders [
                'name':    "UK Cities"
                'type':    "Settlements"
                'created': "6 Aug"
                'tags':    [ "folder/United Kingdom", "public" ]
            ,
                'name':    "UK Towns"
                'type':    "Settlements"
                'created': "5 Nov"
                'tags':    [ "folder/United Kingdom" ]
            ,
                'name':    "UK Lakes"
                'type':    "Water"
                'created': "13:45"
                'tags':    [ "admin", "folder/United Kingdom" ]
            ,
                'name':    "Czech Ponds"
                'type':    "Water"
                'created': "15 Jan 2011"
                'tags':    [ "public", "folder/Czech Republic" ]
            ,
                'name':    "World Seas"
                'type':    "Water"
                'created': "1 Feb"
            ]
            
            @view = new FoldersView 'collection': collection