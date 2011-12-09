// Todo Statistics View
// ----------

App.Views.TodoStatsView = Backbone.View.extend({

	"el": "#todo-stats",

	// Our template for the line of statistics at the bottom of the app.
	// Compiles JavaScript templates into functions that can be evaluated for rendering.
	"template": _.template(function() {
		var result;
		// **Asynchronously** fetch the template from an external file when needed.
		$.ajax({
			"async": false,
		    "url":   "js/templates/_stats.html",
		  	success: function(data) {
		    	result = data;
		  	},
		});
		return result;
	}()),

	"events": {
		"click .todo-clear a": "clearCompletedTodos"
	},

	// Listen when stats have updated so we can re-render ourselves. We could also bind to the
	// Model itself.
	initialize: function(options) {
		_.bindAll(this, "render");
		App.Mediator.bind("todosStatsUpdated", this.render);
	},

	// Re-render us based on current **Todos Collection**.
	render: function(options) {
		$(this.el).html(this.template({
			"total":      App.Models.Todos.length,
			"done":       App.Models.Todos.done().length,
			"remaining":  App.Models.Todos.remaining().length
		}));
		return this;
	},

	// Clear all done todo items, destroying their Models.
	clearCompletedTodos: function() {
		_.each(App.Models.Todos.done(), function (todo) {
			todo.destroy();
		});
		this.render();
		return false;
	}

});