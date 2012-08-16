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

            # Re-render itself when the underlying objects (all of them) change.
            @modelBind 'change', @render
            # for model in @model.get 'lists'
            #     model.off 'change', @render, @
            #     model.on 'change', @render, @
            # for model in @model.get 'folders'
            #     model.on 'change', @render, @

        # Get the template from here.
        getTemplateFunction: -> JST['folder_objects']

        afterRender: ->
            super

            # Thrash the garbage.
            @undelegate()
            @views.dump()

            # Render the lists.
            for model in @model.get 'lists'
                @views.push new ListView 'model': model
            
            # Render the folders.
            for model in @model.get 'folders'
                @views.push new FolderView 'model': model