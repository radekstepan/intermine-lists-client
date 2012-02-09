# List View in a Sidebar
# ----------
class App.Views.SidebarListView extends Backbone.View

	# Element does not exist yet, but will be a `<li>`.
	tagName: "li"

	# Cache the template function for a single item.
	template: _.template(
		do ->
			result = ""
			$.ajax
				async: false
				url: "js/templates/_sidebar_list.html"
				success: (data) -> result = data
			result
	)

	events:
		"click a": "toggleList"

	toggleList: (e) ->
		# Model change.
		@model.toggleSelected()

		# Prevent default page reload.
		e.preventDefault()

	# We listen to changes to our Model representation, re-rendering.
	initialize: ->
		@model.bind("change", @render, @)
		@model.bind("destroy", @remove, @)

	render: ->
		$(@el).html(@template(@model.toJSON())).attr("data-view", "SidebarListView")
		
		# Are we selected?
		if @model.get("selected") then $(@el).addClass("active") else $(@el).removeClass("active")

		# Chain baby.
		@

	remove: -> $(@el).remove()

	clear: -> @model.destroy()