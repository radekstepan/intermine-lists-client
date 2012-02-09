# List Item Model
# ----------
class window.List extends Backbone.Model

	defaults:
		name:     ""
		slug:     ""
		type:     ""
		created:  ""
		folder:   ""
		selected: false

	initialize: ->
		folder = undefined
		_.find(@["attributes"]["tags"], ( (tag) -> folder = tag.substring(7)  if tag.substring(0, 7) is "folder/" ))

		# Save the folder on us.
		@set(folder: (folder or false))

		# Create/Add (to) a Folder.
		App.Models.Folders.add(new Folder(
			name:     folder
			lists:    [ @["attributes"]["name"] ]
			topLevel: (if (folder) then false else true)
		))

		# Slugify for linking purposes.
		@set(slug: @slugify(@.get("name")))

		# Bind to the change of the selected attr so we can msg abt it. 
		this.bind("change:selected", @selectedChanged);
	
	# Replace rubbish, replace dashes with underscores, spaces with dashes and make it small.
	slugify: (text) -> text.replace(/[^-a-zA-Z0-9,&\s]+/ig, '').replace(/-/gi, "_").replace(/\s/gi, "-").toLowerCase()
   
   	# Toggle the `selected` state of this list item.
	toggleSelected: -> @set(selected: not @get("selected"))

	# Make the list item selected regardles of its current status.
	setSelected: => @set(selected: true)
	
	# Msg to others when our selected status has changed.
	selectedChanged: =>	App.Mediator.trigger((if @get("selected") then "listSelected" else "listDeselected"), @get("slug"))	

# List Items Collection
# ---------------
class window.Lists extends Backbone.Collection

	model: List

	# Filter down the collection of all lists that are selected.
	selected: -> @filter( (list) -> list.get "selected" )

	# Filter down the collection of all lists that are deselected.
	deselected: -> @filter( (list) -> not list.get("selected") )

	byName: (name) -> @find( (list) -> list.get("name") is name )

	bySlug: (slug) -> @find( (list) -> list.get("slug") is slug )

	comparator: (list) -> list.get("name")