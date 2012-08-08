define [
    'chaplin'
    'models/list'
    'models/folders'
], (Chaplin, List, Folders) ->

    # A flat store of all lists (and folders) on a page.
    class Store extends Chaplin.Collection
        
        # A first class object, Folders and Tags are 'niceties'.
        model: List

        # Hold folders here.
        folders: new Folders()

        initialize: (data) ->
            for row in data
                @makeFolder @makeList row

        # Slugify a string.
        slugify: (text) -> text.replace(/[^-a-zA-Z0-9,&\s]+/ig, '').replace(/-/gi, "_").replace(/\s/gi, "-").toLowerCase()

        # Find a list from this collection by its slug.
        findList: (slug) ->
            l = @.filter (item) -> item.get('slug') is slug
            if l.length > 0
                l[0]

        # Make a list out if dict data.
        makeList: (data) ->
            # Slugify the list name.
            data.slug = @slugify data.name
            # Create us and return us.
            @.push data
            @.at(@.length - 1)

        # Given a path find the one matching folder.
        findFolder: (path) ->
            f = @folders.filter (item) -> item.get('path') is path
            if f.length > 0
                f[0]

        # For a given path will (create folder and) link to list (and parent folder).
        makeFolder: (list) ->
            path = list.get('path')

            # Find in existing.
            folder = @findFolder path
            if folder?
                # Append the list reference.
                lists = folder.get 'lists'
                lists.push list
                folder.unset 'lists', 'silent': true
                folder.set 'lists': lists
            
            else
                # No cigar... add a new one linking to this list.
                @folders.push
                    'path':    path
                    'name':    path.split('/').pop() # Last part of the path.
                    'lists':   [ list ]
                    'folders': []

                # Do we need to link this folder to a parent folder?
                parentPath = (p = path.split('/'))[0...p.length - 1].join('/')
                # Linked to root folder including root folder itself.
                if parentPath is '' and path isnt '/' then parentPath = '/'
                if parentPath isnt ''
                    folder = @folders.at(@folders.length - 1)

                    # Does the parent exist already?
                    parent = @findFolder parentPath
                    if parent?
                        # Link us.
                        folders = parent.get('folders')
                        folders.push folder
                        parent.unset 'folders', 'silent': true
                        parent.set 'folders': folders
                    
                    else
                        # Create a new folder and link to this folder.
                        @folders.push
                            'path':    parentPath
                            'name':    parentPath.split('/').pop() # Last part of the path.
                            'lists':   []
                            'folders': [ folder ]