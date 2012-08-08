define [
    'view'
    'views/sidebar_list'
    'views/sidebar_folder'
], (View, SidebarListView, SidebarFolderView) ->

    class SidebarFolderView extends View

        tagName: 'li' # a list item

        # Get the template from here.
        getTemplateFunction: -> JST['folder']

        # 'Serialize' our opts.
        getTemplateData: -> @model.toJSON()

        afterRender: ->
            super

            # Render our lists.
            for list in @model.get 'lists'
                $(@el).find('ul.lists').first().append (new SidebarListView('model': list)).render().el

            # Render our folders.
            for folder in @model.get 'folders'
                $(@el).find('ul.folders').first().append (new SidebarFolderView('model': folder)).render().el