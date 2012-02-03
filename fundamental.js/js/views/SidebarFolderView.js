// Folder View in a Sidebar
// ----------

App.Views.SidebarFolderView = Backbone.View.extend({

	// Element does not exist yet, but will be a `<li>`.
	"tagName":  "li",

	// Cache the template function for a single item.
	"template": _.template(function() {
		var result;
		$.ajax({
			"async": false,
		    "url":   "js/templates/_folder.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	// The DOM events specific to a Folder.
	"events": {
		"click a.toggle": "toggleFolder"
	},

	toggleFolder: function() {
		$(this.el).toggleClass('active').find('ul').toggleClass('active');
	},

	// We listen to changes to our Model representation, re-rendering.
	initialize: function() {
		this.model.bind("change", this.render, this);
		this.model.bind("destroy", this.remove, this);
	},

	// Re-render the contents of the folder.
	render: function() {
		var folder = this.model;
		// A top level folder? Set it as expanded.
		if (folder.get("topLevel")) folder.set({"expanded": true});

		$(this.el).html(this.template(folder.toJSON())); // serialize to JSON, fill tml, set as innerHTML

		// Add a data attr to the view.
		var name = folder.get("name") || 'top';
		$(this.el).attr("data-list-name", name);

		return this;
	},

	// Remove this view from the DOM.
	remove: function() {
		$(this.el).remove();
	},

	// Remove the item, destroy the model.
	clear: function() {
		this.model.destroy();
	}

});