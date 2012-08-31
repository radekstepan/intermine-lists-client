View = require 'chaplin/core/View'

# A list being moved around.
module.exports = class ListMovingView extends View

    autoRender: true

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/list_moving'

    afterRender: ->
        super

        $(@el).addClass 'moving'