define [
    'view'
], (View) ->

    class SidebarListView extends View

        tagName: 'li' # a list item

        # Get the template from here.
        getTemplateFunction: -> JST['list']

        # 'Serialize' our opts.
        getTemplateData: -> @model.toJSON()