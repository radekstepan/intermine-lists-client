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
	path:   undefined

	constructor: ->
		tooltip = @
		$('*[data-view]').hover (->
			tooltip.activate(@)
		), ->
			tooltip.deactivate(@)
	
	activate: (element) =>
		console.log element

		# Grab hold of the current View path.
		path = $(element).attr('data-view')
		path = "<strong>#{path}</strong>"
		path += " &lang; " + $(parent).attr('data-view') for parent in $(element).parents('*[data-view]')

		console.log path

		#setTimeout(@showTooltip(), 0) and !@active unless @active
    
	deactivate: ->
		# Remove the label.
		$('div#data-view-label').remove()
	
	showTooltip: ->
		console.log "blaaa"
		# Create a label.
		$('<div/>', { 'id': 'data-view-label', 'class': 'alert alert-info', 'html': =>
			# Give me me and all parents that describe a View.
			text = $(@).attr('data-view')
			text = "<strong>#{text}</strong>"
			text += " &lang; " + $(parent).attr('data-view') for parent in $(@).parents('*[data-view]')
			text
		}).appendTo('body')