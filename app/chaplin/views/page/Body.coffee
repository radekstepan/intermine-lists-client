Mediator = require 'chaplin/core/Mediator'
View = require 'chaplin/core/View'

TitleView = require 'chaplin/views/page/Title'

module.exports = class BodyView extends View

    container:       'body'
    containerMethod: 'html'
    autoRender:      true

    getTemplateFunction: -> require 'chaplin/templates/body'

    initialize: ->
        super

        # Render page title.
        Mediator.subscribe 'pageTitle', @renderTitle

    renderTitle: (opts) ->
        # Kill?
        @view?.dispose()
        @view = new TitleView opts