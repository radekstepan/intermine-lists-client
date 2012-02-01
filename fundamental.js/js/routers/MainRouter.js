// Main App Router
// ----------

App.Routers.Main = Backbone.Router.extend({

    initialize: function(options) {
    	// Initialize the lists using dummy data.
    	var lists = [
    		{'name': 'FlyTF_trusted_TFs', 'type': 'Genes', 'created': '6 Aug', 'selected': false, 'tags': ['public']},
    		{'name': 'FlyAtlas_brain_top', 'type': 'Genes', 'created': '5 Nov', 'selected': false, 'tags': ['folder/group 1']},
    		{'name': 'classIIb', 'type': 'Genes', 'created': '13:45', 'selected': true, 'tags': ['public', 'folder/group 1']}
    	];
    	App.Models.Lists = new Lists(lists);
        
        // Instantiate the table with lists.
		new App.Views.ListCollectionView;

		// Instantiate the toolbar.
        new App.Views.ToolbarView;
    }

});