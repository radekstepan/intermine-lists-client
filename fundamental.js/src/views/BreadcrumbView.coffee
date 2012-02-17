# Breadcrumb for a selected List.
# ----------
class App.Views.BreadcrumbView extends Backbone.View
	
	el: "ul#breadcrumb"

	template: (model) -> super(model, "js/templates/_breadcrumb.html")

	initialize: (options) ->
		App.Mediator.bind("listSelected", @render)
		App.Mediator.bind("listDeselected", @hide)

	# Make sure that only one list is selected at any one time.
	render: (listSlug) =>
		$(@el).html(@template(App.Models.Lists.bySlug(listSlug).toJSON())).show().attr("data-view", "BreadcrumbView")

	# Hide element if no list is selected.
	hide: => $(@el).hide()