define [
    'core/view'
], (View) ->

    class CrumbView extends View

        tagName:         'li'     # a list item
        containerMethod: 'append' # appended
        autoRender:      true     # as soon as we create us

        # Get the template from here.
        getTemplateFunction: -> JST['crumb']