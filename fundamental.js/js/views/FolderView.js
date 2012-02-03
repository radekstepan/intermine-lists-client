// Folder View
// ----------

App.Views.FolderView = Backbone.View.extend({

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

	// We listen to changes to our Model representation, re-rendering.
	initialize: function() {
		this.model.bind("change", this.render, this);
		this.model.bind("destroy", this.remove, this);
	},

	// Re-render the contents of the folder.
	render: function() {
		$(this.el).html(this.template(this.model.toJSON())); // serialize to JSON, fill tml, set as innerHTML
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