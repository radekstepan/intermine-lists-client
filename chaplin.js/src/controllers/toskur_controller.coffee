define [
    'chaplin'
    'models/store'
    'views/sidebar_root_folder'
], (Chaplin, Store, SidebarRootFolderView) ->

    # The main controller of the lists app.
    class TöskurController extends Chaplin.Controller

        historyURL: (params) -> ''

        # Give us the Store.
        initialize: ->
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
                'name': 'Welsh Lakes'
                'path': '/United Kingdom/Wales'
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
            
        index: (params) ->
            # Render the root folder (and onwards) in the sidebar.
            @view = new SidebarRootFolderView 'model': @store.findFolder('/') # save on `view` so is disposed of

        # Show an individual list by its `slug`.
        findOne: (params) ->
            # Retrieve the list in question.
            list = @store.findList params.slug
            unless list?
                Chaplin.mediator.publish 'notification', 'This list has not been found'
            else
                Chaplin.mediator.publish 'notification', 'You have asked for this list', list.get('name')

                # We have the list, so expand the path towards the list.
                @store.expandFolder list.get 'path'

            # Render the root folder (and onwards) in the sidebar.
            @view = new SidebarRootFolderView 'model': @store.findFolder('/') # save on `view` so is disposed of