# Folder Item Model
# ----------
window.Folder = class Folder extends Backbone.Model

	defaults:
		name:     "#"
		lists:    []
		expanded: false
		topLevel: false

# Folder Items Collection
# ---------------
window.Folders = class Folders extends Backbone.Collection
	
	model: Folder
	
	comparator: (folder) -> folder.get("name")

# Detect duplicate folder names so they are not instantiated multiple times, but instead append List to the existing Folder.
Folders::add = (folder) ->
	if (existing = @find( (_folder) -> _folder.get("name") is folder.get("name") ))
		# Folder exists, add the list to existing storage.
		lists = existing.get("lists")
		existing.get("lists").push(folder.get("lists")[0])
		existing.set({"lists": lists});

		# Do not create a new Folder instance.
		return false

	Backbone.Collection::add.call(@, folder)