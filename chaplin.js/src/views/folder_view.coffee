define [
    'chaplin'
    'view'
], (Chaplin, View) ->

    class FolderView extends View

        tagName: 'li'

        getTemplateFunction: -> JST['folder']