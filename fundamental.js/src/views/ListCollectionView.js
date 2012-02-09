// List Collection Table View
// ----------

App.Views.ListCollectionView = Backbone.View.extend({

	"el": "table#table",

	// The DOM events that can happen on a table.
	"events": {
		"click thead input[type='checkbox']": "toggleSelectAll"
	},

	initialize: function(options) {
		_.bindAll(this, "addOneList");
		_.bindAll(this, "renderCheckbox");

		// Listen to when lists are being selected to re-render the check-all checkbox.
		App.Mediator.bind("listSelected", this.renderCheckbox);

		// On initialization, add all existing list items.
		this.addAllLists();
	},

	// Toggle the `selected` state of all lists.
	toggleSelectAll: function() {
		// If some lists are not selected, select them.
		var deselected = App.Models.Lists.deselected();
		if (!_.isEmpty(deselected)) {
			_.each(deselected, function(list) {
				list.toggleSelected();
			});
		} else {
			// Otherwise deselect all lists.
			App.Models.Lists.each(function(list) {
				list.toggleSelected();
			});
		}

		// Trigger a notification so toolbar et al can redraw.
		App.Mediator.trigger("listSelected");
	},

	// Set the status of the checkbox based on whether all lists are selected or not.
	renderCheckbox: function() {
		var checkbox = $(this.el).find('thead input[type="checkbox"]');
		if (App.Models.Lists.deselected().length == 0) {
			// All lists are selected (or there are no lists ;), make sure box is checked.
			checkbox.attr('checked', 'checked');
		} else {
			checkbox.attr('checked', false);
		}
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