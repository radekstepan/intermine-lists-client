define [
    'chaplin'
    'models/lists'
], (Chaplin, Lists) ->

    class Folder extends Chaplin.Model

        defaults:
            'name':     ''    # name of a folder (last part of the path)
            'path':     '/'   # path coming from the list
            'expanded': false # is this folder expanded in the view?

        ###
        Add a list to a folder.
        @param {List} list
        ###
        addList: (list) ->
            # Get the current lists.
            lists = @.get 'lists'
            # Push the new one.
            lists.push list
            # Unset.
            @.unset 'lists', 'silent': true
            # Set
            @.set 'lists': lists

            # Have we had a reverse refence already?
            if (folder = list.get('folder'))?
                # Remove the reference from the folder to the list.
                folder.removeList list.cid

            # Make a reverse reference.
            list.set 'folder': @

        ###
        Pasing a cid of a `List` object, remove a reference to this list.
        @param {string} cid of a `List` object.
        ###
        removeList: (cid) ->
            lists = []
            for list in @.get 'lists'
                if list.cid isnt cid then lists.push list
            @.set 'lists': lists