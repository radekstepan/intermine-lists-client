# List View in a Sidebar
# ----------
App.Views.SidebarListView = class View extends Backbone.View

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

	toggleList: ->
		# Model change.
		@model.toggleSelected()

		# Trigger a message.
		App.Mediator.trigger((if (@model.get("selected")) then "listSelected" else "listDeselected"), @model.get("name"))

	# We listen to changes to our Model representation, re-rendering.
	initialize: ->
		@model.bind("change", @render, @)
		@model.bind("destroy", @remove, @)

	render: ->
		$(@el).html(@template(@model.toJSON()))
		
		# Are we selected?
		if @model.get("selected") then $(@el).addClass("active") else $(@el).removeClass("active")
		
		# Chain baby.
		@

	remove: -> $(@el).remove()

	clear: -> @model.destroy()