define [
    'views/sidebar_list'
    'views/sidebar_folder'
], (SidebarListView, SidebarFolderView) ->

    class SidebarRootFolderView extends SidebarFolderView

        tagName:         'li'         # a list item
        containerMethod: 'append'     # appended
        container:       'ul#folders' # to the top level list
        autoRender:      true         # as soon as we create us