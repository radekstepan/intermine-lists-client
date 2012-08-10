define [
    'core/view'
], (View) ->

    class MainFolderView extends View

        containerMethod: 'html'
        container:       '#main'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['folder']

        getTemplateData: ->
            result = @model.toJSON()
            # Serialize the referred to objects.
            for what in [ 'lists', 'folders' ]
                result[what] = []
                for item in @model.get what
                    result[what].push item.toJSON()

            result