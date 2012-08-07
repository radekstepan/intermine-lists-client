define [
    'chaplin'
    'models/list'
], (Chaplin, List) ->

    # A storage of all lists, resides in Store.
    class Lists extends Chaplin.Collection
        
        model: List