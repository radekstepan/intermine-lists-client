define [
    'core/garbage'
    'core/view'
    'views/list'
    'views/folder'
], (Garbage, View, ListView, FolderView) ->

    # The folder with other folders and lists.
    class MainFolderView extends View

        container:  '#main'
        autoRender: true

        initialize: ->
            super

            # The garbage truck... wroom!
            @views = new Garbage()

        # Get the template from here.
        getTemplateFunction: -> JST['folder_objects']

        afterRender: ->
            super

            # Render the lists.
            for model in @model.get 'lists'
                @views.push view = new ListView 'model': model
            
            # Render the folders.
            for model in @model.get 'folders'
                @views.push view = new FolderView 'model': model