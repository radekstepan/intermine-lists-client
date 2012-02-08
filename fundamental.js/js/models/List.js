// List Item Model
// ----------

var List = Backbone.Model.extend({

	// Attributes of a list item.
	defaults: function() {
		return {
			"name":     "",
			"type":     "",
			"created":  "",
			"folder":   "",
			"selected": false
		};
	},

	// On initializing a List, initialize a containing Folder too.
	initialize: function() {
		// Get the folder by parsing tags or use a top level folder.
		var folder;
		_.find(this['attributes']['tags'], function(tag) {
			if (tag.substring(0, 7) == 'folder/') {
				return folder = tag.substring(7);
			}
		}, this);

		// Save the folder on us.
		this.set({"folder": (folder || false)});

		// Create/Add (to) a Folder.
		App.Models.Folders.add(new Folder({ 'name': folder, 'lists': [this['attributes']['name']], 'topLevel': (folder) ? false : true }));
	},

	// Toggle the `selected` state of this list item.
	toggleSelected: function() {
		this.set({"selected": !this.get("selected")});
	},

	// Make the list item selected regardles of its current status.
	setSelected: function() {
		this.set({"selected": true});
	}

});

// List Items Collection
// ---------------

var Lists = Backbone.Collection.extend({

	// Reference to this collection's model.
	// Override this property to specify the model class that the collection contains.
	"model": List,

	// Filter down the collection of all lists that are selected.
	selected: function() {
		return this.filter(function(list) {
			return list.get("selected");
		});
	},

	// Filter down the collection of all lists that are deselected.
	deselected: function() {
		return this.filter(function(list) {
			return !list.get("selected");
		});
	},

	byName: function(name) {
		return this.find(function(list) {
			return list.get("name") == name;
		});		
	},

	// If you define a comparator, it will be used to maintain the collection in a sorted order.
	comparator: function(list) {
		return list.get("name");
	}

});