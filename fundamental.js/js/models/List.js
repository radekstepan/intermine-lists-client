// List Item Model
// ----------

var List = Backbone.Model.extend({

	// Attributes of a list item.
	defaults: function() {
		return {
			"name":     "Default name",
			"type":     "Genes",
			"created":  "Today",
			"selected": false,
			"folder": null
		};
	},

	// Toggle the `selected` state of this list item.
	toggleSelected: function() {
		this.save({"selected": !this.get("selected")});
	},

	// Make the list item selected regardles of its current status.
	setSelected: function() {
		this.save({"selected": true});
	}

});

// List Items Collection
// ---------------

var Lists = Backbone.Collection.extend({

	// Reference to this collection's model.
	// Override this property to specify the model class that the collection contains.
	"model": List,

	// Save all of the list items under the `lists` namespace.
	"localStorage": new Store("lists"),

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

	// If you define a comparator, it will be used to maintain the collection in a sorted order.
	comparator: function(list) {
		return list.get("name");
	}

});