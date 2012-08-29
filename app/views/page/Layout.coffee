Chaplin = require 'chaplin'

View = require '/core/View'
Garbage = require '/core/Garbage'

NotificationView = require 'views/page/Notification'
BodyView = require 'views/page/Body'
FilterView = require 'views/head/Filter'
ActionsView = require 'views/page/Actions'

# Whole body experience.
module.exports = class LayoutView extends View

    autoRender: true

    initialize: ->
        super

        # App wide notification.
        Chaplin.mediator.subscribe 'notification', @notify

    # (Re-)init all core Views.
    # Actually, as we are on a Controller, we will die every time we change the Action.
    render: ->
        # Store all Views here.
        @views ?= new Garbage()
        # Clear any previous.
        @views.dump()

        # Main body of the page.
        @views.push new BodyView()
        # List filtering.
        @views.push new FilterView()
        # Create folder, organise lists etc.
        @views.push new ActionsView()

    ###
    Create a new notification.
    @param {string} text Text of the notification message.
    @param {string} title Text of the notification message title, not required.
    @param {string} type Type of the message, determines CSS class (notify/warn/error)
    @param {boolean} sticky Close automagically or stick around?
    ###
    notify: (text, title, type='notify', sticky=false) ->
        new NotificationView text, title, type, sticky