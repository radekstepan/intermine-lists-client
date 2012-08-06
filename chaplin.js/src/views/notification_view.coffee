define [
    'chaplin'
], (Chaplin) ->

    # An app wide message.
    class NotificationView extends Chaplin.View

        tagName:         'li'               # a list item
        containerMethod: 'append'           # appended
        container:       'ul#notifications' # to a list
        autoRender:      true               # as soon as we create us

        # Get the template from here.
        getTemplateFunction: -> JST['notification']

        # 'Serialize' our opts.
        getTemplateData: ->
            'title': @title
            'text':  @text

        # Opts and events.
        initialize: (@text, @title, @type, @sticky) ->
            @

            @delegate 'click', 'a', @close

        # Add to container.
        afterRender: ->
            super

            @

            $(@el).hide().addClass(@type).slideDown()

            setTimeout(@close, 3000) unless @sticky

        # Dispose of.
        close: =>
            $(@el).slideUp("fast")
            @dispose