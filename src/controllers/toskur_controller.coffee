define [
    'chaplin'
    'core/garbage'
    'models/store'
    'views/sidebar_root_folder'
    'views/sidebar_lists'
    'views/sidebar_filter'
    'views/breadcrumb'
    'views/main_folder'
], (Chaplin, Garbage, Store, SidebarRootFolderView, SidebarListsView, SidebarFilterView, BreadcrumbView, MainFolderView) ->

    # The main controller of the lists app.
    class TöskurController extends Chaplin.Controller

        historyURL: (params) -> ''

        initialize: ->
            # Storage for objects to be garbage collected.
            @views = new Garbage()

            # Give us the Store.
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

            # Render the root folder (and onwards) in the sidebar.
            @views.push 'lists', new SidebarRootFolderView 'model': @store.findFolder('/')

            # Sidebar filtering.
            @views.push new SidebarFilterView()

            # Receive filter list messages.
            Chaplin.mediator.subscribe 'filterLists', @filterLists

            # What to show in the main View?
            Chaplin.mediator.subscribe 'expandFolder', @changeMainView
            Chaplin.mediator.subscribe 'showRoot', @changeMainView

        # Need to dispose of us listening to `filterLists`.
        dispose: ->
            channels = [
                'filterLists'
                'expandFolder'
                'showRoot'
            ]
            for channel in channels
                Chaplin.mediator.unsubscribe channel

            super

        ###
        The user wants to filter the sidebar lists.
        @param {string} filter
        ###
        filterLists: (filter) =>
            # Get rid of existing lists listing.
            @views.disposeOf 'lists'

            # Is this a 'clearing' query?
            if filter is ''
                @views.push 'lists', new SidebarRootFolderView 'model': @store.findFolder('/')
            else
                # Filter the collection.
                re = new RegExp "#{filter}.*", 'i'
                coll = new Chaplin.Collection @store.filter (list) -> list.get('name').match re
                
                # Push all to a lists View.
                @views.push 'lists', new SidebarListsView 'collection': coll

        ###
        Sidebar says we should update the main View.
        @param {Folder} model If passed says to change the main View to this one.
        ###        
        changeMainView: (model=@store.findFolder('/')) =>
            @views.disposeOf 'main'
            
            # We are dealing with folders.
            if model.constructor.name is 'Folder'
                # Make a new View for us.
                @views.push 'main', new MainFolderView 'model': model

        ###
        Show the default index page.
        @param {Object} params Passed in properties
        ###
        index: (params) ->

        ###
        Show an individual list by its `slug`.
        @param {Object} params Passed in properties
        ###
        findOne: (params) ->
            # Retrieve the list in question.
            list = @store.findList params.slug
            unless list?
                Chaplin.mediator.publish 'notification', 'This list has not been found'
            else
                Chaplin.mediator.publish 'notification', 'You have asked for this list', list.get('name')

                # We have the list, so expand the path towards the list.
                @store.expandFolder list.get 'path'

                # Create a breadcrumb View for this list.
                @views.push new BreadcrumbView 'collection': @store.getPath list