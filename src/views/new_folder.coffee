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