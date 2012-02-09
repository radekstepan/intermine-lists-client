# Folder Collection View in the Sidebar
# ----------
class App.Views.SidebarFolderCollectionView extends Backbone.View

	el: "ul#folders"

	initialize: (options) ->
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
	addOneFolder: (folder) =>
		$(@el).append(new App.Views.SidebarFolderView(model: folder).render().el).attr("data-view", "SidebarFolderCollectionView")

	# Add all folders.
	addAllFolders: -> App.Models.Folders.each(@addOneFolder)