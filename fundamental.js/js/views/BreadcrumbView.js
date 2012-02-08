// Breadcrumb for a selected List.
// ----------

App.Views.BreadcrumbView = Backbone.View.extend({

	"el": "ul#breadcrumb",

	// Cache the template function for a single item.
	"template": _.template(function() {
		var result;
		$.ajax({
			"async": false,
		    "url":   "js/templates/_breadcrumb.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	initialize: function(options) {
		_.bindAll(this, "render");

		App.Mediator.bind("listSelected", this.render);
	},

	// Make sure that only one list is selected at any one time.
	render: function(listName) {
		$(this.el).html(this.template(App.Models.Lists.byName(listName).toJSON()));

		return this;
	}


});