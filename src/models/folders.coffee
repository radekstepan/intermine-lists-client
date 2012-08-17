define [
    'chaplin'
    'models/folder'
], (Chaplin, Folder) ->

    # A storage of all folders, resides in Store.
    class Folders extends Chaplin.Collection
        
        model: Folder

        ###
        Slugify a string.
        @param {string} text
        ###
        slugify: (text) -> text.replace(/[^-a-zA-Z0-9,&\s]+/ig, '').replace(/-/gi, "_").replace(/\s/gi, "-").toLowerCase()