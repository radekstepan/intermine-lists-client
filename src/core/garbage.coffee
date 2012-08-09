define ->

    # An object implementing the `dispose` fce to garbage collect all of its `objects` internals.
    class Garbage

        objects: null

        # New store for objects.
        constructor: -> @objects = []

        ###
        Array-like interface for pushing objects onto the stack.
        @param {Object} object Usually a View that we want to later dispose of.
        ###
        push: (object) -> @objects.push object

        # Interface for Chaplin calls.
        dispose: ->
            # Remove all my internals.
            for obj in @objects
                if obj and typeof obj.dispose is 'function'
                    obj.dispose()

            # And now the store itself.
            delete @['objects']

            # Non extensible, non writable, useless...
            Object.freeze? @