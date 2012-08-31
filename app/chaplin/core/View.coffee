Chaplin = require 'chaplin'

module.exports = class View extends Chaplin.View

    afterRender: ->
        super

        # unless (name = @.constructor.name) is 'NotificationView'
        #     Chaplin.mediator.publish 'notification', "#{name} rendered"