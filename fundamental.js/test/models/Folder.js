// Folder Item Model
// ----------

var Folder = Backbone.Model.extend({

	// Attributes of a folder item.
	defaults: function() {
		return {
			"name":     "#", // by default lists go to a top level Folder
			"lists":    [],
			"expanded": false,
			"topLevel": false
		};
	}

});

// Folder Items Collection
// ---------------

var Folders = Backbone.Collection.extend({

	// Reference to this collection's model.
	"model": Folder,

	// If you define a comparator, it will be used to maintain the collection in a sorted order.
	comparator: function(folder) {
		return folder.get("name");
	}

});

// Detect duplicate folder names so they are not instantiated multiple times, but instead append List to the existing Folder.
Folders.prototype.add = function(folder) {
	var existing = this.find(function(_folder) { 
		return _folder.get('name') === folder.get('name');
	});
	if (existing) {
		// Folder exists, add the list to existing storage.
		var lists = existing.get("lists");
		existing.get("lists").push(folder.get("lists")[0]);
		existing.set({"lists": lists});

		// Do not create a new Folder instance.
		return false;
	}

	Backbone.Collection.prototype.add.call(this, folder);
}