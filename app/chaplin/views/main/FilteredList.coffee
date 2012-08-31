ListView = require 'chaplin/views/main/List'
ListMovingView = require 'chaplin/views/main/ListMoving'

module.exports = class FilteredListView extends ListView

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/filtered_list'