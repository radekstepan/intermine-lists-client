# Main App Router
# ----------
App.Routers.Main = class Router extends Backbone.Router

    initialize: (options) ->
        # Initialize Folders storage.
        App.Models.Folders = new Folders()

        # Initialize the lists using dummy data.
        lists = [
            name: "UK Cities"
            type: "Settlements"
            created: "6 Aug"
            tags: [ "folder/United Kingdom", "public" ]
        ,
            name: "UK Towns"
            type: "Settlements"
            created: "5 Nov"
            tags: [ "folder/United Kingdom" ]
        ,
            name: "UK Lakes"
            type: "Water"
            created: "13:45"
            tags: [ "admin", "folder/United Kingdom" ]
        ,
            name: "Czech Ponds"
            type: "Water"
            created: "15 Jan 2011"
            tags: [ "public", "folder/Czech Republic" ]
        ,
            name: "World Seas"
            type: "Water"
            created: "1 Feb"
        ]
        App.Models.Lists = new Lists(lists)

        # Show the Sidebar Folder View.
        new App.Views.SidebarFolderCollectionView

        # Breadcrumb.
        new App.Views.BreadcrumbView