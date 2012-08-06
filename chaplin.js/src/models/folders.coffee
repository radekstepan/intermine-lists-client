define [
    'chaplin'
    'models/folder'
], (Chaplin, Folder) ->

    class Folders extends Chaplin.Collection
        
        model: Folder

        add: (folder) ->
            if (existing = @find( (_folder) -> _folder.get('name') is folder.get('name') ))
                # Folder exists, add the list to existing storage.
                lists = existing.get('lists')
                existing.get('lists').push(folder.get("lists")[0])
                existing.set 'lists': lists

                # Do not create a new Folder instance.
                return false

            Chaplin.Collection::add.call(@, folder)