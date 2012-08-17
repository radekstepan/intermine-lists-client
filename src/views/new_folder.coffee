define [
    'core/view'
], (View) ->

    class NewFolderView extends View

        container:       '#popover'
        containerMethod: 'html'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['new_folder']

        afterRender: ->
            super

            @delegate 'click', 'a.cancel', @dispose
            @delegate 'click', 'a.close', @dispose
            @delegate 'click', 'a.create', @create

        # Create the folder.
        create: (e) ->
            # Get the name.
            name = $(@el).find('input.name').val()

            # Do we have anything beyond whitespace?
            if (name = $.trim(name)).length isnt 0
                # Now construct a new path for the created list.
                path = [ @model.get('path'), name ].join('/').replace(/\/\//g, '/') # root folder is just one '/'

                # Do we have such a path already?
                if (@model.collection.where 'path': path).length is 0
                    console.log 'good list'
            
            # Die either way...
            @dispose()
