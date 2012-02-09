# Folder Collection View in the Sidebar
# ----------
App.Views.SidebarFolderCollectionView = class View extends Backbone.View

	el: "ul#folders"

	initialize: (options) ->
		_.bindAll(@, "addOneFolder")
		
		App.Mediator.bind("listSelected", @deselectOtherLists)
		
		# On initialization, add all contained Folders.
		@addAllFolders()

	# Make sure that only one list is selected at any one time.
	deselectOtherLists: (folderName) ->
		_.each(App.Models.Lists.selected(), (
			(list) ->
				list.set(selected: false) unless list.get("name") is folderName
		))

	# Add a folder to the listing.
	addOneFolder: (folder) ->
		$(@el).append(new App.Views.SidebarFolderView(model: folder).render().el).attr("data-view", "SidebarFolderCollectionView")

	# Add all folders.
	addAllFolders: -> App.Models.Folders.each(@addOneFolder)