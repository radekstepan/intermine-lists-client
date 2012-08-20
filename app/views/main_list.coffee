Garbage = require 'core/garbage'
View = require 'core/view'
ListObjectView = require 'views/list_object'

# The list and its contents.
module.exports = class MainListView extends View

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