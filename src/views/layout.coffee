define [
    'chaplin'
    'views/notification'
    'views/body'
    'views/filter'
    'views/actions'
    'templates/all' # make all templates globally available
], (Chaplin, NotificationView, BodyView, FilterView, ActionsView) ->

    # Whole body experience.
    class Layout extends Chaplin.Layout

        initialize: ->
            super

            # App wide notification.
            Chaplin.mediator.subscribe 'notification', @notify

            # Our first message.
            Chaplin.mediator.publish 'notification', 'Welcome to InterMine'

            # Global Views that stick around and do not need to be garbage collected.
            new BodyView()
            new FilterView()
            new ActionsView()

        ###
        Create a new notification.
        @param {string} text Text of the notification message.
        @param {string} title Text of the notification message title, not required.
        @param {string} type Type of the message, determines CSS class (notify/warn/error)
        @param {boolean} sticky Close automagically or stick around?
        ###
        notify: (text, title, type='notify', sticky=false) ->
            new NotificationView text, title, type, sticky