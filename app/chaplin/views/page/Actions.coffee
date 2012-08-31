Chaplin = require 'chaplin'

View = require 'chaplin/core/View'
Garbage = require 'chaplin/core/Garbage'

NewFolderView = require 'chaplin/views/page/NewFolder'
OrganiseListsView = require 'chaplin/views/page/OrganiseLists'

module.exports = class ActionsView extends View

    container:  '#actions'
    autoRender: true

    # Number of checked lists.
    checked: 0

    # The currently active folder.
    folder: undefined

    # Link to main Store.
    store: null

    getTemplateFunction: -> require 'chaplin/templates/actions'

    getTemplateData: -> 'checked': @checked

    initialize: ->
        super

        @views = new Garbage()

        # Main Store.
        @store = window.Store

        # Listen to lists being checked.
        Chaplin.mediator.subscribe 'checkedLists', (@checked) => @render()

        # Listen to the current active folder.
        Chaplin.mediator.subscribe 'activeFolder', (@folder) =>

        # Events.
        @delegate 'click', 'a.new-folder', @newFolder
        @delegate 'click', 'a.organise', @organise

    newFolder: =>
        # Create a popover View to handle the interaction.
        @views.push new NewFolderView 'model': @folder

    organise: =>
        # Create a popover View to handle the interaction.
        # Pass in a Collection of selected lists.
        @views.push new OrganiseListsView
            'collection': new Chaplin.Collection @store.where('checked': true)
            'model': @folder