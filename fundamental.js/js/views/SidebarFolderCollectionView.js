// Folder Collection View in the Sidebar
// ----------

App.Views.SidebarFolderCollectionView = Backbone.View.extend({

	"el": "ul#folders",

	initialize: function(options) {
		_.bindAll(this, "addOneFolder");

		// Listen to when folders are to be expanded.
		App.Mediator.bind("sidebarFolderExpanded", this.folderExpanded);

		// On initialization, add all contained Folders.
		this.addAllFolders();
	},

	// Set the status of the checkbox based on whether all lists are selected or not.
	folderExpanded: function(folderName) {
		console.log(folderName);
	},

	// Add a folder to the listing.
	addOneFolder: function(folder) {
		// A top level folder? Set it as expanded.
		if (folder.get("topLevel")) folder.set({"expanded": true});

		// Create the View and render.
		var view = new App.Views.FolderView({model: folder}).render().el;
		
		// Add a data attr to the view.
		var name = folder.get("name") || 'top';
		$(view).attr("data-list-name", name);

		// Is it expanded?
		if (folder.get("expanded")) {
			// Set class in template and append to the list.
			$(this.el).append($(view).addClass("active"));
			// Emit a message to show the contained Lists.
			App.Mediator.trigger("sidebarFolderExpanded", name);
		} else {
			// Append to the list.
			$(this.el).append(view);			
		}
	},

	// Add all folders.
	addAllFolders: function() {
		App.Models.Folders.each(this.addOneFolder);
	},


});