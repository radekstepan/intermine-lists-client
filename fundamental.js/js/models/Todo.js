// Todo Item Model
// ----------

var Todo = Backbone.Model.extend({

	// Default attributes for a todo item. Attribute `text` is implied.
	defaults: function() {
		return {
			"done":  false,
			"order": App.Models.Todos.nextOrder() // what if I can not haz initialized?
		};
	},

	// Toggle the `done` state of this todo item.
	toggle: function() {
		this.save({"done": !this.get("done")});
	}

});

// Todo Items Collection
// ---------------

// The collection of todos is backed by *localStorage* instead of a remote server.
var TodoList = Backbone.Collection.extend({

	// Reference to this collection's model.
	// Override this property to specify the model class that the collection contains.
	"model": Todo,

	// Save all of the todo items under the `"todos"` namespace.
	"localStorage": new Store("todos"),

	// Filter down the list of all todo items that are finished.
	done: function() {
		return this.filter(function (todo) {
			return todo.get("done"); // all items with `done` attr set to true
		});
	},

	// Filter down the list to only todo items that are still not finished.
	remaining: function() {
		return this.without.apply(this, this.done()); // reverse of `done()` filter
	},

	// We keep the **Todos** in sequential order, despite being saved by unordered
	// GUID in the database. This generates the next order number for new items.
	nextOrder: function() {
		if (!this.length) return 1; // first item
		return this.last().get("order") + 1; // last +1
	},

	// Todos are sorted by their original insertion order.
	// If you define a comparator, it will be used to maintain the collection in sorted order.
	comparator: function(todo) {
		return todo.get("order");
	}

});