Chaplin = require 'chaplin'

View = require 'core/View'

module.exports = class OrganiseListsView extends View

    container:       '#popover'
    containerMethod: 'html'
    autoRender:      true

    # Link to main Store.
    store: window.Store

    # Get the template from here.
    getTemplateFunction: -> require 'templates/organise_lists'

    afterRender: ->
        super

        @delegate 'click', 'a.cancel', @dispose
        @delegate 'click', 'a.close',  @dispose
        @delegate 'click', 'a.apply',  @apply

        # Additional keypress events.
        @delegate 'keyup', (e) =>
            switch e.keyCode
                when 27 then @dispose()
                when 13 then @apply()

    # Apply the folder changes.
    apply: (e) ->        
        # Die either way...
        @dispose()