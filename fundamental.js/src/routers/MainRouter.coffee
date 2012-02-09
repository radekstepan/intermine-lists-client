# Main App Router
# ----------
class App.Routers.Main extends Backbone.Router

    routes:
        "":           "routeIndex"
        "list/:slug": "routeList"

    initialize: ->
    	# Bind listening to when a list is selected, change the URL then.
    	App.Mediator.bind("listSelected", @urlShowList)
    	App.Mediator.bind("listDeselected", @urlShowIndex)

    # The default route.
    routeIndex: ->

    # Router should determine if List requested exists and if so, change its state on Model, otherwise deselect all Lists.
    routeList: (slug) ->
        if list = App.Models.Lists.bySlug(slug) then list.setSelected() else _.each(App.Models.Lists.selected(),
        	(list) -> list.set("selected": false)
        )
    
    # Check if we have any Lists selected and if not show "index".
    urlShowIndex: =>
        document.title = "All Lists - InterMine MyMine"
        @.navigate("") if App.Models.Lists.selected.length is 0

    # Change the address bar on selecting a list.
    urlShowList: (slug) =>
        name = App.Models.Lists.bySlug(slug).get("name")
        document.title = "#{name} - InterMine MyMine"
        @.navigate("list/#{slug}")