ListView = require 'views/list'
ListMovingView = require 'views/list_moving'

module.exports = class FilteredListView extends ListView

    # Get the template from here.
    getTemplateFunction: -> require 'templates/filtered_list'