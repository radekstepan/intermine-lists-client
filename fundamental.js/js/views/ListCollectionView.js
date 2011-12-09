// List Collection Table View
// ----------

App.Views.ListCollectionView = Backbone.View.extend({

	"el": "table#table tbody",

	initialize: function(options) {
		_.bindAll(this, "addOneList");

		// On initialization, add all existing list items.
		this.addAllLists();
	},

	// Add a single list item to the table by creating a view for it, and
	// appending its element to the `<tbody>`.
	addOneList: function(list) {
		var view = new App.Views.ListItemView({model: list});
		$(this.el).append(view.render().el); // TODO fix this hack
	},

	// Add all items in the Lists collection at once.
	addAllLists: function() {
		App.Models.Lists.each(this.addOneList);
	},

});