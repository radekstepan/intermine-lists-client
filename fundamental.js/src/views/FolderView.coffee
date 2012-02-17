# Main Folder View
# ----------
class App.Views.FolderView extends Backbone.View
	
	tagName: "table"

	template: (model) -> super(model, "js/templates/_folder.html")