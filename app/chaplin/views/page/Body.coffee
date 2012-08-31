View = require 'chaplin/core/View'

module.exports = class BodyView extends View

    container:       'body'
    containerMethod: 'html'
    autoRender:      true

    getTemplateFunction: -> require 'chaplin/templates/body'

    dispose: -> 'You no kill `Body`'