define [
    'chaplin'
    'models/folder'
], (Chaplin, Folder) ->

    # A storage of all folders, resides in Store.
    class Folders extends Chaplin.Collection
        
        model: Folder