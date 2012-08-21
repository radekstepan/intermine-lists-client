ListView = require 'views/main/List'
ListMovingView = require 'views/main/ListMoving'

module.exports = class FilteredListView extends ListView

    # Get the template from here.
    getTemplateFunction: -> require 'templates/filtered_list'