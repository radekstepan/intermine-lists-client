Mediator = require 'chaplin/core/Mediator'
View = require 'chaplin/core/View'

NotificationView = require 'chaplin/views/page/Notification'
BodyView = require 'chaplin/views/page/Body'
FilterView = require 'chaplin/views/head/Filter'
ActionsView = require 'chaplin/views/page/Actions'

# Whole body experience.
module.exports = class LayoutView extends View

    autoRender: true

    initialize: ->
        super

        # App wide notification.
        Mediator.subscribe 'notification', @notify

    # Init all core Views.
    render: ->
        # Main body of the page.
        @subview 'Body', new BodyView()
        # List filtering.
        @subview 'Filter', new FilterView()
        # Create folder, organise lists etc.
        @subview 'Actions', new ActionsView()

    ###
    Create a new notification.
    @param {string} text Text of the notification message.
    @param {string} title Text of the notification message title, not required.
    @param {string} type Type of the message, determines CSS class (notify/warn/error)
    @param {boolean} sticky Close automagically or stick around?
    ###
    notify: (text, title, type='notify', sticky=false) ->
        new NotificationView text, title, type, sticky