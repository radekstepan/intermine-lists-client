define [
    'chaplin'
    'core/view'
    'views/sidebar_list'
    'views/sidebar_folder'
], (Chaplin, View, SidebarListView, SidebarFolderView) ->

    class SidebarFolderView extends View

        tagName: 'li' # a list item

        # Get the template from here.
        getTemplateFunction: -> JST['sidebar_folder']

        # 'Serialize' our opts and add cid so we can constrain events.
        getTemplateData: -> _.extend { 'cid': @model.cid }, @model.toJSON()

        # Render the subviews.
        afterRender: ->
            super

            # Dispose of previous subviews and clean up events.
            @undelegate()
            ( view.dispose() for view in @subviews )

            # Events only on this folder.
            @delegate 'click', ".folder.#{@model.cid}.toggle", @toggleFolder
            @delegate 'click', ".folder.#{@model.cid}.select", @selectFolder
            @modelBind 'change', @render

            #console.log "folder #{@model.get('path')} `#{@model.cid}` - #{@model.get('lists').length} lists and #{@model.get('folders').length} folders"

            # Render the subviews.
            if @model.get('path') is '/' or @model.get('expanded')
                # Render our lists.
                # for list in @model.get 'lists'
                #     $(@el).find('ul.lists').first().append (v = new SidebarListView('model': list)).render().el
                #     @subviews.push v

                # Render our folders.
                for folder in @model.get 'folders'
                    $(@el).find('ul.folders').first().append (v = new SidebarFolderView('model': folder)).render().el
                    @subviews.push v

            # If we have folders then show a toggler for this folder.
            if @model.get('folders').length isnt 0
                $(@el).find(".folder.#{@model.cid}.toggle").addClass do =>
                    if @model.get 'expanded' then 'active icon-caret-down'
                    else 'active icon-caret-right'

        # Toggle the folder, the view is listening to Model changes already.
        toggleFolder: -> @model.set 'expanded', isExpanded = !@model.get('expanded')

        selectFolder: -> console.log 'selected'