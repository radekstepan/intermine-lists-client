Mediator = require 'chaplin/core/Mediator'
View = require 'chaplin/core/View'

module.exports = class TitleView extends View

    container:       'header#title'
    containerMethod: 'html'
    autoRender:      true

    getTemplateFunction: -> require 'chaplin/templates/title'

    initialize: (opts) ->
        super
        @[key] = value for key, value of opts

    getTemplateData: ->
        'title': @title
        'subtitle': @subtitle