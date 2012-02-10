# Maintaining the whole of app layout.
# ----------
class App.Views.LayoutView extends Backbone.View
	
	# Attach straight to body to monitor all that happens.
	el: "body"

	initialize: (options) ->
		# Show the Sidebar Folder View.
        new App.Views.SidebarFolderCollectionView

        # Breadcrumb.
        new App.Views.BreadcrumbView