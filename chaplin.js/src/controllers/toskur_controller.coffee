define [
    'chaplin'
    'models/store'
], (Chaplin, Store) ->

    # The main controller of the lists app.
    class TöskurController extends Chaplin.Controller

        historyURL: (params) -> ''

        initialize: ->
            # Central repo of all lists and folders. Passing a structure of lists.
            @store = new Store [
                'name': 'UK Cities'
                'path': '/United Kingdom'
            ,
                'name': 'UK Towns'
                'path': '/United Kingdom'
            ,
                'name': 'UK Lakes'
                'path': '/United Kingdom'
            ,
                'name': 'Czech Ponds'
                'path': '/Czech Republic'
            ,
                'name': 'Czech Villages'
                'path': '/Czech Republic'
            ,
                'name': 'World Seas'
                'path': '/'
                'expanded': true
            ]

        # Show a listing of all root lists and folders in the sidebar.
        index: (params) ->
            console.log @store.folders
            #new SidebarView 'collection': collection