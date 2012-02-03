// Main App Router
// ----------

App.Routers.Main = Backbone.Router.extend({

    initialize: function(options) {
    	// Initialize the lists using dummy data.
    	var lists = [
    		{'name': 'UK Cities', 'type': 'Settlements', 'created': '6 Aug', 'selected': false, 'tags': ['public']},
    		{'name': 'UK Towns', 'type': 'Settlements', 'created': '5 Nov', 'selected': false, 'tags': ['folder/United Kingdom']},
    		{'name': 'UK Lakes', 'type': 'Water', 'created': '13:45', 'selected': false, 'tags': ['public', 'folder/United Kingdom']},
            {'name': 'Czech Ponds', 'type': 'Water', 'created': '15 Jan 2011', 'selected': false, 'tags': ['public', 'folder/Czech Republic']}
    	];
    	App.Models.Lists = new Lists(lists);
        
        // Instantiate the table with lists.
		new App.Views.ListCollectionView;

		// Instantiate the toolbar.
        new App.Views.ToolbarView;
    }

});