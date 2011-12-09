// Main App Router
// ----------

App.Routers.Main = Backbone.Router.extend({

    initialize: function(options) {
    	// Initialize new **Todos Collection** and fetch them from db.
    	App.Models.Todos = new TodoList;
		App.Models.Todos.fetch();

		// Instantiate the main **Views**.
        new App.Views.CreateTodoView;
        
		new App.Views.TodoStatsView;

        new App.Views.TodoListView;
    }

});