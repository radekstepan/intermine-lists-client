Garbage = require 'chaplin/core/Garbage'
View = require 'chaplin/core/View'

ListObjectView = require 'chaplin/views/main/ListObject'

# The list and its contents.
module.exports = class ListObjectHolderView extends View

    container:  '#main'
    autoRender: true

    initialize: ->
        super

        # The garbage truck... wroom!
        @views = new Garbage()

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/list_objects'

    getTemplateData: ->
        # Render the table head peeking on the first object.
        'head': Object.keys @collection.models[0].toJSON()

    afterRender: ->
        super

        # Render the children.
        for model in @collection.models
            @views.push view = new ListObjectView 'model': model