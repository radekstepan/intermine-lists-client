// List View in a Sidebar
// ----------

App.Views.SidebarListView = Backbone.View.extend({

	// Element does not exist yet, but will be a `<li>`.
	"tagName":  "li",

	// Cache the template function for a single item.
	"template": _.template(function() {
		var result;
		$.ajax({
			"async": false,
		    "url":   "js/templates/_sidebar_list.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	// The DOM events specific to a List.
	"events": {
		"click a": "toggleList"
	},

	toggleList: function() {
		// Model change.
		this.model.toggleSelected();
		
		// Trigger a message.
		App.Mediator.trigger((this.model.get("selected")) ? "listSelected" : "listDeselected", this.model.get("name"));
	},

	// We listen to changes to our Model representation, re-rendering.
	initialize: function() {
		this.model.bind("change", this.render, this);
		this.model.bind("destroy", this.remove, this);
	},

	// Re-render the contents of the folder.
	render: function() {
		$(this.el).html(this.template(this.model.toJSON())); // serialize to JSON, fill tml, set as innerHTML

		// Are we selected?
		if (this.model.get("selected")) {
			$(this.el).addClass('active');
		} else {
			$(this.el).removeClass('active');
		}

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