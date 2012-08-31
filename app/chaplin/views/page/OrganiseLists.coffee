Mediator = require 'chaplin/core/Mediator'
View = require 'chaplin/core/View'

OrganiseFolderHolderView = require 'chaplin/views/tree/OrganiseFolderHolder'

module.exports = class OrganiseListsView extends View

    container:       '#popover'
    containerMethod: 'html'
    autoRender:      true

    # Here be Store.
    store: null

    initialize: (opts...) ->
        super

        assert window.Store? and @collection? and @model?, 'OrganiseLists::initialize'

        # Main Store.
        @store = window.Store

        # When a folder gets selected we can enable the apply button.
        Mediator.subscribe 'selectFolder', (@selectedFolder) ->
            # Is at least one list in a different folder from this one?
            disable = true

            # Bug 125, 132.
            assert @collection?, 'Collection of selected lists needs to be provided'

            @collection.each (list) => if list.get('path') isnt @selectedFolder.get('path') then ( disable = false ; return {} )

            if disable
                $(@el).find('a.apply').addClass 'disabled'
            else
                $(@el).find('a.apply').removeClass 'disabled'
        , @

        # When a tree folder gets rendered we can tell them who the selected folder is.
        Mediator.subscribe 'treeFolderRendered', ->
            # If we actually have a selected folder...
            if @selectedFolder?
                Mediator.publish 'selectFolder', @selectedFolder
        , @

    # Get the template from here.
    getTemplateFunction: -> require 'chaplin/templates/organise_lists'

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
            # The new path.
            newPath = @selectedFolder.get('path')

            # For each list in a Collection...
            @collection.each (list) =>
                # The old path.
                oldPath = list.get('path')

                # Are the paths the same?
                if newPath isnt oldPath
                    # Message about it.
                    Mediator.publish 'notification', "Has been moved from \"#{oldPath}\" to \"#{newPath}\"", list.get('name')

                    # Update the list path itself.
                    list.set 'path', newPath

                    # Push the list on the selected folder.
                    @selectedFolder.addList list

            Mediator.publish 'renderMain'

            # Die either way...
            @dispose()