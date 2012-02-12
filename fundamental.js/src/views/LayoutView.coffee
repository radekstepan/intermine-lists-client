# Maintaining the whole of app layout.
# ----------
class App.Views.LayoutView extends Backbone.View
	
	# Attach straight to body to monitor all that happens.
	el: "body"

	initialize: (options) ->
		# Notifications View.
        new App.Views.NotificationsView().render()

		# Show the Sidebar Folder View.
        new App.Views.SidebarFolderCollectionView

        # Breadcrumb.
        new App.Views.BreadcrumbView

        # View tooltip helper.
        new ViewTooltip


# Show us a Growl style notification.
# ----------
class App.Views.NotificationsView extends Backbone.View

	el: "ul#notifications"

	# Listen in on notifications.
	# bind = string; which message to listen to?
	initialize: (options) ->
		App.Mediator.bind(options?.bind or "notification", @notify)
		@

	# Create a new notification.
	# type = notify/warn/error; type of the message, determines CSS class
	# sticky = true/false; close automagically or stick?
	notify: (text, title, type="notify", sticky=false) =>
		$(@el).append(new App.Views.NotificationView(text, title, type, sticky).render().el)

	# Just to add out name to the data attr.
	render: ->
		$(@el).attr("data-view", "NotificationsView")
		@


# The individual notification.
# ----------
class App.Views.NotificationView extends Backbone.View

	# Element does not exist yet, but will be a `<li>`.
	tagName: "li"

	# Cache the template function for a single item.
	template: _.template(
		do ->
			result = ""
			$.ajax
				async: false
				url: "js/templates/_layout_notification.html"
				success: (data) -> result = data
			result
	)

	# The DOM events.
	events:
		"click a": "close"

	# Set on the Object and chain so we can render.
	initialize: (@text, @title, @type, @sticky) -> @

	render: ->
		$(@el).hide().html(@template({'text': @text, 'title': @title})).addClass(@type).slideDown().attr("data-view", "NotificationView")

		# Pure love :)
		setTimeout(@close, 3000) unless @sticky

		@
	
	close: => $(@el).slideUp("fast")


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