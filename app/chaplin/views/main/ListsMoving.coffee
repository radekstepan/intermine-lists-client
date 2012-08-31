View = require 'chaplin/core/View'

# Multiple lists being dragged around.
module.exports = class ListsMovingView extends View

    autoRender: true

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/lists_moving'

    getTemplateData: -> 'size': @collection.length

    afterRender: ->
        super

        $(@el).addClass 'moving'