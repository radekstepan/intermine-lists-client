// Folder Collection View in the Sidebar
// ----------

App.Views.SidebarFolderCollectionView = Backbone.View.extend({

	"el": "ul#folders",

	initialize: function(options) {
		_.bindAll(this, "addOneFolder");

		App.Mediator.bind("listSelected", this.deselectOtherLists);

		// On initialization, add all contained Folders.
		this.addAllFolders();
	},

	// Make sure that only one list is selected at any one time.
	deselectOtherLists: function(folderName) {
		_.each(App.Models.Lists.selected(), function(list) {
			if (list.get("name") != this) {
				list.set({"selected": false});
			}
		}, folderName);
	},

	// Add a folder to the listing.
	addOneFolder: function(folder) {
		// Render a new View and append to the list.
		$(this.el).append(new App.Views.SidebarFolderView({model: folder}).render().el);
	},

	// Add all folders.
	addAllFolders: function() {
		App.Models.Folders.each(this.addOneFolder);
	},


});