Chaplin = require 'chaplin'

Mediator = require 'chaplin/core/Mediator'

module.exports = class View extends Chaplin.View

    afterRender: ->
        super

        # unless (name = @.constructor.name) is 'NotificationView'
        #     Mediator.publish 'notification', "#{name} rendered"

    # Stop listening to our music.
    dispose: ->
        Mediator.unsubscribe null, null, @

        super