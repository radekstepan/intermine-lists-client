define [
    'chaplin'
], (Chaplin) ->

    class Folder extends Chaplin.Model

        defaults:
            'name':     "#"
            'lists':    []
            'expanded': false
            'topLevel': false