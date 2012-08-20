View = require 'core/view'

module.exports = class ListObjectView extends View

    container:       '#main table tbody'
    tagName:         'tr'
    containerMethod: 'append'
    autoRender:      true

    # Get the template from here.
    getTemplateFunction: -> require 'templates/list_object'

    getTemplateData: ->
        'values': ( value for _, value of @model.toJSON() )