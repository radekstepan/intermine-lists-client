define [
    'core/view'
], (View) ->

    class SidebarListView extends View

        tagName: 'li' # a list item

        # Get the template from here.
        getTemplateFunction: -> JST['list']

        # 'Serialize' us with our cid.
        getTemplateData: -> @model.toJSON()