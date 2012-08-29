Chaplin = require 'chaplin'

View = require 'core/View'

OrganiseFolderHolderView = require 'views/tree/OrganiseFolderHolder'

module.exports = class OrganiseListsView extends View

    container:       '#popover'
    containerMethod: 'html'
    autoRender:      true

    # Here be Store.
    store: null

    initialize: ->
        super

        # Main Store.
        @store = window.Store

        # When a folder gets selected we can enable the apply button.
        Chaplin.mediator.subscribe 'selectFolder', (@selectedFolder) => $(@el).find('a.apply').removeClass 'disabled'

        # When a tree folder gets rendered we can tell them who the selected folder is.
        Chaplin.mediator.subscribe 'treeFolderRendered', =>
            # If we actually have a selected folder...
            if @selectedFolder?
                Chaplin.mediator.publish 'selectFolder', @selectedFolder

    # Get the template from here.
    getTemplateFunction: -> require 'templates/organise_lists'

    getTemplateData: ->
        'lists':    @collection.pluck('name')
        'locations': _(@collection.pluck('path')).uniq().join(', ')

    afterRender: ->
        super

        @renderTree()

        # Some events.
        @undelegate()

        @delegate 'click', 'a.cancel', @dispose
        @delegate 'click', 'a.close',  @dispose
        @delegate 'click', 'a.apply',  @apply

        # Additional keypress events.
        @delegate 'keyup', (e) =>
            switch e.keyCode
                when 27 then @dispose()
                when 13 then @apply()

    # Dispose of existing Tree of Folders and render again.
    renderTree: ->
        # Render the Folder tree View.
        @view?.dispose()
        @view = new OrganiseFolderHolderView 'model': @store.findFolder('/')

    # Apply the folder changes.
    apply: (e) ->
        if @selectedFolder?
            console.log @selectedFolder

            # Die either way...
            @dispose()