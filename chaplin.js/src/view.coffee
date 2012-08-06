define [
    'chaplin'
], (Chaplin) ->

    class View extends Chaplin.View

        afterRender: ->
            super

            unless (name = @.constructor.name) is 'NotificationView'
                Chaplin.mediator.publish 'notification', "#{name} rendered"