// List Item View
// ----------

App.Views.ListItemView = Backbone.View.extend({

	// Element does not exist yet, but will be a `<tr>`.
	"tagName":  "tr",

	// Cache the template function for a single item.
	"template": _.template(function() {
		var result;
		$.ajax({
			"async": false,
		    "url":   "js/templates/_list.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	// The DOM events specific to an item.
	"events": {
		"click input[type='checkbox']": "toggleSelected"
	},

	// We listen to changes to our Model representation, re-rendering.
	// If the view defines an initialize function, it will be called when the view is first created.
	initialize: function() {
		this.model.bind("change", this.render, this);
		this.model.bind("destroy", this.remove, this);
	},

	// Re-render the contents of the list item.
	// Override this function with your code that renders the view template from model data, and updates this.el with the new HTML.
	render: function() {
		$(this.el).html(this.template(this.model.toJSON())); // serialize to JSON, fill tml, set as innerHTML
        // Is this item selected? Tag `<tr>` is not part of the template.
        if (this.model.get("selected")) $(this.el).addClass('selected');
		return this;
	},

	// Toggle the `selected` state of the list.
	toggleSelected: function() {
		// Toggle the item class in the template.
		$(this.el).toggleClass('selected');

		// Update the Model.
		this.model.toggleSelected();
		
		// Trigger a notification so toolbar et al can redraw.
		App.Mediator.trigger("listSelected");
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