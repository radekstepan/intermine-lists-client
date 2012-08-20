Chaplin = require 'chaplin'
Folder = require 'models/folder'

# A storage of all folders, resides in Store.
module.exports = class Folders extends Chaplin.Collection
    
    model: Folder