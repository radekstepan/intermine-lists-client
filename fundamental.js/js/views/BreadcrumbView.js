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
		_.bindAll(this, "hide");

		App.Mediator.bind("listSelected", this.render);
		App.Mediator.bind("listDeselected", this.hide);
	},

	// Make sure that only one list is selected at any one time.
	render: function(listName) {
		$(this.el).html(this.template(App.Models.Lists.byName(listName).toJSON())).show();

		return this;
	},

	// Hide element if no list is selected.
	hide: function() {
		$(this.el).hide();
	}


});