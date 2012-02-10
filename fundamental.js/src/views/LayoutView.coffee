# Maintaining the whole of app layout.
# ----------
class App.Views.LayoutView extends Backbone.View
	
	# Attach straight to body to monitor all that happens.
	el: "body"

	# For determining which View we are hovering over.
	viewTooltip:
		active: false
		path:   undefined

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

	constructor: ->
		$('*[data-view]').hover(@activate, @deactivate)
	
	activate: ->
		# Create a label.
		$('<div/>', { 'id': 'data-view-label', 'class': 'alert alert-info', 'html': =>
			# Give me me and all parents that describe a View.
			text = $(@).attr('data-view')
			text = "<strong>#{text}</strong>"
			text += " &lang; " + $(parent).attr('data-view') for parent in $(@).parents('*[data-view]')
			text
		}).appendTo('body')
    
	deactivate: ->
		# Remove the label.
		$('div#data-view-label').remove()