# Breadcrumb for a selected List.
# ----------
App.Views.BreadcrumbView = class View extends Backbone.View
	
	el: "ul#breadcrumb"

	# Cache the template function for a single item.
	template: _.template(
		do ->
			result = ""
			$.ajax
				async: false
				url: "js/templates/_breadcrumb.html"
				success: (data) -> result = data
			result
	)

	initialize: (options) ->		
		App.Mediator.bind("listSelected", @render)
		App.Mediator.bind("listDeselected", @hide)

	# Make sure that only one list is selected at any one time.
	render: (listName) =>
		$(@el).html(@template(App.Models.Lists.byName(listName).toJSON())).show().attr("data-view", "BreadcrumbView")

	# Hide element if no list is selected.
	hide: => $(@el).hide()