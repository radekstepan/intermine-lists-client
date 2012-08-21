Chaplin = require 'chaplin'

View = require 'core/View'

module.exports = class NewFolderView extends View

    container:       '#popover'
    containerMethod: 'html'
    autoRender:      true

    # Get the template from here.
    getTemplateFunction: -> require 'templates/new_folder'

    afterRender: ->
        super

        @delegate 'click', 'a.cancel', @dispose
        @delegate 'click', 'a.close',  @dispose
        @delegate 'click', 'a.create', @create

        # Additional keypress events.
        @delegate 'keyup', (e) =>
            switch e.keyCode
                when 27 then @dispose()
                when 13 then @create()

        # Give focus to the input field.
        $(@el).find('input.name').focus()

    # Create the folder.
    create: (e) ->
        # Get the name.
        name = $(@el).find('input.name').val()

        # Do we have anything beyond whitespace?
        if (name = $.trim(name)).length isnt 0
            # Now construct a new path for the created list.
            path = [ @model.get('path'), name.latinise().slugify() ].join('/').replace(/\/\//, '/')

            # Do we have such a path already?
            if (@model.collection.where 'path': path).length is 0
                # OK, push the new folder.
                @model.collection.push
                    'path':    path
                    'name':    path.split('/').pop().replace(/\-/g, ' ') # last part of the path.
                    'lists':   []
                    'folders': []
                    'slug':    path[1...] # the path except the leading forward slash
                    'active':  false

                # Get the added folder.
                folder = @model.collection.at(@model.collection.length - 1)

                # Link to this folder from the parent.
                folders = @model.get('folders')
                folders.push folder
                @model.unset 'folders', 'silent': true
                @model.set 'folders': folders

                # Make a back reference to the parent.
                folder.set 'parent': @model

                # Tell the main View to re-render.
                Chaplin.mediator.publish 'renderMain'

                # And say what we just did.
                Chaplin.mediator.publish 'notification', 'A new folder has been created', folder.get('name')
        
        # Die either way...
        @dispose()