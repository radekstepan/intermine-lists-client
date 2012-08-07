define [
    'models/lists'
    'models/folders'
], (Lists, Folders) ->

    # A flat store of all lists (and folders) on a page.
    class Store
        
        # Storage
        lists:   new Lists()
        folders: new Folders()

        constructor: (data) ->
            for row in data
                @makeFolder (@makeList(row)).get('path')

        # Make a list out if dict data.
        makeList: (data) ->
            @lists.push data
            @lists.at(@lists.length - 1)

        # For a given path will create folder if needed.
        makeFolder: (path='/') ->
            # Find in existing.
            f = @folders.filter (item) -> item.get('path') is path
            return if f.length > 0

            # No cigar... push a new one.
            @folders.add
                'path': path
                'name': path.split('/').pop()

        # Resolve a path to a collection of folders/lists.
        getPath: (path='/') ->
            f = @folders.filter (folder) -> folder.get('path') is path
            if f.length > 0
                # Now give us lists.
                l = @lists.filter (list) -> list.get('path') is path
                
                'folders': f
                'lists':   l