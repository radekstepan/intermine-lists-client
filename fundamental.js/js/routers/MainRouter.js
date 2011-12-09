// Main App Router
// ----------

App.Routers.Main = Backbone.Router.extend({

    initialize: function(options) {
    	// Initialize the lists using dummy data.
    	var lists = [
    		{'name': 'FlyTF_trusted_TFs', 'type': 'Genes', 'created': '6 Aug', 'selected': false},
    		{'name': 'FlyAtlas_brain_top', 'type': 'Genes', 'created': '5 Nov', 'selected': false},
    		{'name': 'classIIb', 'type': 'Genes', 'created': '13:45', 'selected': false}
    	];
    	App.Models.Lists = new Lists(lists);
        
        // Instantiate the table with lists.
		new App.Views.ListCollectionView;

		// Instantiate the toolbar.
        new App.Views.ToolbarView;
    }

});