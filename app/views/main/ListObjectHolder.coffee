Garbage = require 'core/Garbage'
View = require 'core/View'

ListObjectView = require 'views/main/ListObject'

# The list and its contents.
module.exports = class ListObjectHolderView extends View

    container:  '#main'
    autoRender: true

    initialize: ->
        super

        # The garbage truck... wroom!
        @views = new Garbage()

    # Get the template from here.
    getTemplateFunction: -> require 'templates/list_objects'

    getTemplateData: ->
        # Render the table head peeking on the first object.
        'head': Object.keys @collection.models[0].toJSON()

    afterRender: ->
        super

        # Render the children.
        for model in @collection.models
            @views.push view = new ListObjectView 'model': model