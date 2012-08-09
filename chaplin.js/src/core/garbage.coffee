define [
    'chaplin'
], (Chaplin) ->

    # An object implementing the `dispose` fce to garbage collect all of its `objects` internals.
    class Garbage

        objects: null

        # New store for objects.
        constructor: -> @objects = []

        # Array-like interface.
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