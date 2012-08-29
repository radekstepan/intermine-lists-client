View = require 'core/View'

module.exports = class BodyView extends View

    container:       'body'
    containerMethod: 'html'
    autoRender:      true

    getTemplateFunction: -> require 'templates/body'

    dispose: -> 'You no kill `Body`'