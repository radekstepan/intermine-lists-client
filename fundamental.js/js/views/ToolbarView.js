// Lists Toolbar Actions View
// ----------

App.Views.ToolbarView = Backbone.View.extend({

	// Bind to an existing element.
	"el":  "#toolbar",

	// Template handling the buttons in the toolbar.
	// Compiles JavaScript templates into functions that can be evaluated for rendering.
	"template": _.template(function() {
		var result;
		// Synchronously fetch the template from an external file when needed.
		$.ajax({
			"async": false,
		    "url":   "js/templates/_toolbar.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	// The DOM events to bind to.
	"events": {
		"click div.btn.create-folder":  "createFolder"
	},

	initialize: function(options) {
		_.bindAll(this, "render");
		// Listen to when lists are being selected to re-render us.
		App.Mediator.bind("listSelected", this.render);

		// Show us.
		this.render();
	},

	// Re-render us based on the list items selected.
	render: function(options) {
		$(this.el).html(this.template({
			"selected": App.Models.Lists.selected().length
		}));
		return this;
	},

	createFolder: function(e) {
		// Say that the "create folder" button in the toolbar has been clicked.
		App.Mediator.trigger("createFolder");
	}

});