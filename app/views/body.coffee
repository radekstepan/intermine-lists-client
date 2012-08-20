View = require 'core/view'
require 'templates/body'

module.exports = class BodyView extends View

    container:       'body'
    containerMethod: 'html'
    autoRender:      true

    getTemplateFunction: -> require 'templates/body'