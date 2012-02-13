# Folder View in a Sidebar
# ----------
class App.Views.SidebarFolderView extends Backbone.View
	
	tagName: "li"

	# Cache the template function for a single item.
	template: _.template(
		do ->
			result = ""
			$.ajax
				async: false
				url: "js/templates/_sidebar_folder.html"
				success: (data) -> result = data
			result
	)

	# The DOM events specific to a Folder.
	events:
		"click a.toggle": "toggleFolder"

	toggleFolder: -> $(@el).toggleClass("active").find("ul").toggleClass("active")

	# We listen to changes to our Model representation, re-rendering.
	initialize: ->
		@model.bind("change", @render, @)
		@model.bind("destroy", @remove, @)
		
		# Re-render the shebang with a filter applied.
		App.Mediator.bind("filterLists", @filterLists)

	# Fetch the List from Lists based on listName and pass it into the View.
	addOneList: (listName) =>
		list = App.Models.Lists.find( (list) -> list.get("name") is listName )
		$(@el).find("ul.lists").append(new App.Views.SidebarListView(model: list).render().el)

	# Show only filtered lists.
	filterLists: (filter) =>
		# Remove the current list.
		$(@el).find("ul.lists *").remove()

		# SQL LIKE - like case-insensitive regex.
		re = new RegExp("#{filter}.*", "i")

		# Filter the listing (SQL LIKE - like) and add items back
		@addOneList(listName) for listName in @model.get("lists") when listName.match(re)

	# Re-render the contents of the folder.
	render: ->
		folder = @model
		# A top level folder? Set it as expanded.
		folder.set(expanded: true) if folder.get("topLevel")
		
		# serialize to JSON, fill tml, set as innerHTML
		$(@el).html(@template(folder.toJSON())).attr("data-view", "SidebarFolderView")
		
		# Add a data attr to the view.
		name = folder.get("name") or "top"
		$(@el).attr("data-folder-name", name)

		# Create a View for each List contained.
		_.each(folder.get("lists"), @addOneList)

		# chain baby
		@

	# Remove this view from the DOM.
	remove: => $(@el).remove()

	# Remove the item, destroy the model.
	clear: -> @model.destroy()