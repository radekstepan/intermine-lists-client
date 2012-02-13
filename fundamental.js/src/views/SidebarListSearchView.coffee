# Filtering the lists.
# ----------
class App.Views.SidebarListSearchView extends Backbone.View
	
	el: "input#list-search"

	events:
    	keyup: "filter"

    # Send a message with the value we are searching for.
	filter: => App.Mediator.trigger("filterLists", $(@el).attr("value"))