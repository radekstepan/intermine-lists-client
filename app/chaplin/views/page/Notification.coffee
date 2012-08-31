View = require 'chaplin/core/View'

# An app wide message.
module.exports = class NotificationView extends View

    tagName:         'li'               # a list item
    containerMethod: 'append'           # appended
    container:       'ul#notifications' # to a list
    autoRender:      true               # as soon as we create us

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/notification'

    # 'Serialize' our opts.
    getTemplateData: ->
        'title': @title
        'text':  @text

    ###
    Create a new notification.
    @param {string} text Text of the notification message.
    @param {string} title Text of the notification message title, not required.
    @param {string} type Type of the message, determines CSS class (notify/warn/error)
    @param {boolean} sticky Close automagically or stick around?
    ###
    initialize: (@text, @title, @type, @sticky) ->
        @

        @delegate 'click', 'a', @close

    # Add to container.
    afterRender: ->
        super

        $(@el).hide().addClass(@type).slideDown()

        setTimeout(@close, 3000) unless @sticky

    # Dispose of.
    close: => # being passed around...
        $(@el).slideUp("fast")
        @dispose