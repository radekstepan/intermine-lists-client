define ->

    # An object implementing the `dispose` fce to garbage collect all of its `objects` internals.
    class Garbage

        objects: null

        # New store for objects.
        constructor: -> @objects = {}

        # An index for unnamed objects.
        index: 0

        ###
        Array-like interface for pushing objects onto the stack.
        @param {Object} object Usually a View that we want to later dispose of.
        or
        @param {string} key Key to save object under for later disposal...
        @param {Object} object Usually a View that we want to later dispose of.
        ###
        push: (params...) ->
            if params.length is 2
                [key, value] = params
                if typeof(key) isnt 'string' then new Error 'First parameter to `push` needs to be a name of the object'
                # Are we trying to override?
                if @objects[key]? then new Error "Object `#{key}` is already stored, clear it first"
                # Save it under a custom key.
                @objects[key] = value
            else
                if params.length isnt 1 then new Error 'You can pass either one or two params to `push`'
                # Save under an index.
                @objects['obj' + @index++] = params[0]

        ###
        Dispose of a particular view in the dump.
        @param {string} key Get rid of an object referred to by this key.
        ###
        disposeOf: (key) ->
            new Error "Object `#{key}` does not exist" unless @objects[key]?
            # Dispose.
            @objects[key]?.dispose()
            # Delete the key.
            delete @objects[key]

        # Remove all my internals.
        dump: ->
            for key, obj of @objects
                obj?.dispose()

        # Interface for Chaplin calls.
        dispose: ->
            @dump()
            
            # And now the store itself.
            delete @['objects']

            # Non extensible, non writable, useless...
            Object.freeze? @