View = require 'chaplin/core/View'

module.exports = class CrumbView extends View

    tagName:         'li'     # a list item
    containerMethod: 'append' # appended
    autoRender:      true     # as soon as we create us

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/crumb'