# List Item Model
# ----------
class window.List extends Backbone.Model

	defaults:
		name:     ""
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

   
   	# Toggle the `selected` state of this list item.
	toggleSelected: -> @set(selected: not @get("selected"))

	# Make the list item selected regardles of its current status.
	setSelected: -> @set(selected: true)

# List Items Collection
# ---------------
class window.Lists extends Backbone.Collection

	model: List

	# Filter down the collection of all lists that are selected.
	selected: -> @filter( (list) -> list.get "selected" )

	# Filter down the collection of all lists that are deselected.
	deselected: -> @filter( (list) -> not list.get("selected") )

	byName: (name) -> @find( (list) -> list.get("name") is name )

	comparator: (list) -> list.get("name")