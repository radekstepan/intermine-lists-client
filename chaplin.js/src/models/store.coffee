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

        # Make a list out if dict data.
        makeList: (data) ->
            @.push data
            @.at(@.length - 1)

        # For a given path will create folder if needed.
        makeFolder: (list) ->
            path = list.get('path')

            # Find in existing.
            f = @folders.filter (item) -> item.get('path') is path
            if f.length > 0
                folder = f[0]

                # Append the list reference.
                lists = folder.get 'lists'
                lists.push list
                folder.unset 'lists', 'silent': true
                folder.set 'lists': lists
            
            else
                # No cigar... add a new one linking to this list.
                @folders.add
                    'path':  path
                    'name':  path.split('/').pop() # Last part of the path.
                    'lists': [ list ]