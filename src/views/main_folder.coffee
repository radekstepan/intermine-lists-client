define [
    'chaplin'
    'core/garbage'
    'core/view'
    'views/list'
    'views/folder'
], (Chaplin, Garbage, View, ListView, FolderView) ->

    # The folder with other folders and lists.
    class MainFolderView extends View

        container:       '#main'
        autoRender:      true
        containerMethod: 'html'

        initialize: ->
            super

            # The garbage truck... wroom!
            @views = new Garbage()

            # We are not re-rendering on change of the underlying `Folder` Model as otherwise when say dropping multiple `Lists`
            # on a `Folder`, we would re-render too quickly and have access to objects that no longer exist. Thus we need to
            # manually say to this `Folder` when to re-render after we have done operations on it.
            # @modelBind 'change', @render
            Chaplin.mediator.subscribe 'renderMain', @render

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
                # Keep reference to us so that children can tell us when to draw ourselves pretty again...
                @views.push new FolderView 'model': model, parent: @