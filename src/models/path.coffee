define [
    'chaplin'
], (Chaplin) ->

    # A serialized path to a list (in a folder) for breadcrumbs.
    class Path extends Chaplin.Collection

        initialize: ->
            super

            # Keep index of element's position.
            @position = 0

        ###
        Reverse order of items so we start with the top most item although items added from bottom up.
        @param {object} item A model.
        ###
        comparator: (item) -> - item.get('position')

        ###
        Add a list to the collection.
        @param {List} list
        ###
        addList: (list) ->
            @push
                'type':    'list'
                'name':    list.get 'name'
                'position': @position++

        ###
        Add a folder to the collection.
        @param {Folder} folder
        ###
        addFolder: (folder) ->
            name = folder.get('path').split('/').pop()
            if name isnt ''
                @push
                    'cid':      folder.cid
                    'type':     'folder'
                    'name':     name
                    'position': @position++
                    'slug':     folder.get 'slug'