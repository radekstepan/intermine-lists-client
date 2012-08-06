define [
    'chaplin'
], (Chaplin) ->

    class Layout extends Chaplin.Layout

        initialize: ->
            super
            #@subscribeEvent 'startupController', @doSomething