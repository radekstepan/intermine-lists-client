define [
    'views/sidebar_folder'
], (SidebarFolderView) ->

    class SidebarRootFolderView extends SidebarFolderView

        tagName:         'li'         # a list item
        containerMethod: 'html'       # overriding everything
        container:       'ul#folders' # in the top level list
        autoRender:      true         # as soon as we create us