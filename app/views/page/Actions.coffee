Chaplin = require 'chaplin'

View = require 'core/View'
Garbage = require 'core/Garbage'

NewFolderView = require 'views/page/NewFolder'

module.exports = class ActionsView extends View

    container:  '#actions'
    autoRender: true

    # Number of checked lists.
    checked: 0

    # The currently active folder.
    folder: undefined

    getTemplateFunction: -> require 'templates/actions'

    getTemplateData: ->
        'checked': @checked

    initialize: ->
        super

        @views = new Garbage()

        # Listen to lists being checked.
        Chaplin.mediator.subscribe 'checkedLists', (@checked) => @render()

        # Listen to the current active folder.
        Chaplin.mediator.subscribe 'activeFolder', (@folder) =>

    afterRender: ->
        super

        console.log "#{@checked} lists are selected"

        @delegate 'click', 'a.new-folder', @newFolder

    newFolder: =>
        # Create a popover View to handle the interaction.
        @views.push new NewFolderView 'model': @folder