OrganiseFolderView = require 'chaplin/views/tree/OrganiseFolder'

# A root folder '/' holding all the other content.
module.exports = class OrganiseFolderHolderView extends OrganiseFolderView

    tagName:         'li'      # a list item
    containerMethod: 'html'    # overriding everything
    container:       'ul#tree' # in the top level list
    autoRender:      true      # as soon as we create us