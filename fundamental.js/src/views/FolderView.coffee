# Main Folder View
# ----------
class App.Views.FolderView extends Backbone.View
	
	tagName: "table"

	# Cache the template function for a single item.
	template: _.template(
		do ->
			result = ""
			$.ajax
				async: false
				url: "js/templates/_folder.html"
				success: (data) -> result = data
			result
	)