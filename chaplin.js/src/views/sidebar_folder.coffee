define [
    'view'
    'views/sidebar_list'
    'views/sidebar_folder'
], (View, SidebarListView, SidebarFolderView) ->

    class SidebarFolderView extends View

        tagName: 'li' # a list item

        # Get the template from here.
        getTemplateFunction: -> JST['folder']

        # 'Serialize' our opts and add cid so we can constrain events.
        getTemplateData: -> _.extend { 'cid': @model.cid }, @model.toJSON()

        # Render the subviews.
        afterRender: ->
            super

            # Dispose of previous subviews.
            ( view.dispose() for view in @subviews )

            # Events only on this folder.
            @undelegate() # clean up first
            @delegate 'click', "a.folder.#{@model.cid}", @toggleFolder
            @modelBind 'change', @render

            # Render the subviews.
            if @model.get('path') is '/' or @model.get('expanded')
                # Render our lists.
                for list in @model.get 'lists'
                    $(@el).find('ul.lists').first().append (v = new SidebarListView('model': list)).render().el
                    @subviews.push v

                # Render our folders.
                for folder in @model.get 'folders'
                    $(@el).find('ul.folders').first().append (v = new SidebarFolderView('model': folder)).render().el
                    @subviews.push v

        # Toggle the folder, the view is listening to Model changes already.
        toggleFolder: -> @model.set 'expanded', !@model.get('expanded')