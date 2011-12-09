// Create Todo View
// ----------

App.Views.CreateTodoView = Backbone.View.extend({

	// Bind to an existing element.
	"el":  "#create-todo",

	// The DOM events to bind to.
	"events": {
		"keypress #new-todo":  "createTodoOnEnter"
	},

	// Keep a local reference to an input field.
	initialize: function() {
		this.input = this.$("#new-todo");	
	},

	// If you hit return in the main input field, and there is text to save,
	// create new **Todo** model persisting it to *localStorage*.
	createTodoOnEnter: function(e) {
		var text = this.input.val();
		if (!text || e.keyCode != 13) return;
		
		// Create new **Todo**.
		var todo = App.Models.Todos.create({text: text});
		
		this.input.val('');

		// Say a **Todo** has been created and pass it round.
		App.Mediator.trigger("todoCreated", todo);
	}

});