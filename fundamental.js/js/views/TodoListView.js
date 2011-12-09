// Todo List View
// ----------

App.Views.TodoListView = Backbone.View.extend({

	"el": "#todos",

	initialize: function(options) {
		// Bind to `todoCreated` notification so we can update the list view.
		_.bindAll(this, "addOneTodo");
		App.Mediator.bind("todoCreated", this.addOneTodo);

		// On initialization, add all existing **Todo** items.
		this.addAllTodos();
	},

	// Add a single todo item to the list by creating a view for it, and
	// appending its element to the `<ul>`.
	addOneTodo: function(todo) {
		var view = new App.Views.TodoView({model: todo});
		$("#todo-list").append(view.render().el);

		// Send a notification that we need to update the stats.
		App.Mediator.trigger("todosStatsUpdated");
	},

	// Add all items in the **Todos** collection at once.
	addAllTodos: function() {
		App.Models.Todos.each(this.addOneTodo);
	},

});