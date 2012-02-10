# InterMine MyMine App
# ----------
window.App =
    Mediator: {}
    
    Models: {}
    Views: {}
    Routers: {}
    
    initialize: ->
        # Used to pass notifications round.
        _.extend(App.Mediator, Backbone.Events)

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

        # Set the main application router.
        new App.Routers.Main
        # Start history so we can bookmark links.
        Backbone.history.start()

# Initialize the app when DOM is ready.
$ ->
    App.initialize()

    # Show us which View we are hovering over.
    $('*[data-view]').hover(
        ->
            # Remove previous label.
            $('div#data-view-label').remove()
            # Create a label.
            $('<div/>', { 'id': 'data-view-label', 'class': 'alert alert-info', 'html': =>
                # Give me me and all parents that describe a View.
                text = $(@).attr('data-view')
                text = "<strong>#{text}</strong>"
                text += " &lang; " + $(parent).attr('data-view') for parent in $(@).parents('*[data-view]')
                text
            }).appendTo('body')
        , ->
            # Remove previous label.
            $('div#data-view-label').remove()
    )