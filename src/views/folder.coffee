define [
    'core/view'
], (View) ->

    class FolderView extends View

        container:       '#main table tbody'
        tagName:         'tr'
        containerMethod: 'append'
        autoRender:      true

        # Get the template from here.
        getTemplateFunction: -> JST['folder']