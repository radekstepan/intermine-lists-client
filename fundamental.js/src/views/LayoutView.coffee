# Maintaining the whole of app layout.
# ----------
class App.Views.LayoutView extends Backbone.View
	
	# Attach straight to body to monitor all that happens.
	el: "body"

	initialize: (options) ->
		# Show the Sidebar Folder View.
        new App.Views.SidebarFolderCollectionView

        # Breadcrumb.
        new App.Views.BreadcrumbView

        # View tooltip helper.
        new ViewTooltip

 
# Show us which View we are hovering over.
# ----------
class window.ViewTooltip

	# For determining which View we are hovering over.
	active: false
	path:   ""

	constructor: ->
		tooltip = @
		# Attach to current and future elements.
		$('*[data-view]').live "mouseover mouseout", (event) ->
			if event.type is "mouseover"
				tooltip.activate(@)
			else
				tooltip.deactivate(@)

	# Grab hold of the current View path and save it if it is longer than the "previous" one.
	activate: (element) =>
		path = $(element).attr('data-view')
		path = "<strong>#{path}</strong>"
		path += " &lang; " + $(parent).attr('data-view') for parent in $(element).parents('*[data-view]')

		@path = path unless path.length < @path.length

		# Timeout showing of the tooltip.
		setTimeout(@showTooltip, 0) and !@active unless @active
    
    # Remove the label and reset.
	deactivate: =>
		$('div#data-view-label').remove()
		@active = false
		@path = ""
	
	showTooltip: =>
		# Create and show the label.
		$('<div/>', { 'id': 'data-view-label', 'class': 'alert alert-info', 'html': @path }).appendTo('body') unless @path.length is 0

		# Text emmited, reset.
		@active = false
		@path = ""