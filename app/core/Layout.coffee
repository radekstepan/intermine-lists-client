Chaplin = require 'chaplin'

Garbage = require '/core/Garbage'

NotificationView = require 'views/page/Notification'
BodyView = require 'views/page/Body'
FilterView = require 'views/head/Filter'
ActionsView = require 'views/page/Actions'

# Whole body experience.
module.exports = class Layout extends Chaplin.Layout

    initialize: ->
        super

        # Main body of the page.
        new BodyView()
        # List filtering.
        new FilterView()
        # Create folder, organise lists etc.
        new ActionsView()

        # App wide notification.
        Chaplin.mediator.subscribe 'notification', @notify

        # Our first message.
        Chaplin.mediator.publish 'notification', 'Welcome to InterMine'

    ###
    Create a new notification.
    @param {string} text Text of the notification message.
    @param {string} title Text of the notification message title, not required.
    @param {string} type Type of the message, determines CSS class (notify/warn/error)
    @param {boolean} sticky Close automagically or stick around?
    ###
    notify: (text, title, type='notify', sticky=false) ->
        new NotificationView text, title, type, sticky