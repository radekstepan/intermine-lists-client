# Main App Router
# ----------
class App.Routers.Main extends Backbone.Router

    routes:
        "list/:slug": "list"

    # Router should determine if List requested exists and if so, change its state on Model, otherwise deselect all Lists.
    list: (slug) ->
        if list = App.Models.Lists.bySlug(slug) then list.setSelected() else _.each(App.Models.Lists.selected(),
        	(list) -> list.set("selected": false)
        )