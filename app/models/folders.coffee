Chaplin = require 'chaplin'
Folder = require 'models/folder'

# A storage of all folders, resides in Store.
module.exports = class Folders extends Chaplin.Collection
    
    model: Folder

    data: [
        {
            "name": "UK Cities",
            "path": "/United Kingdom"
        },
        {
            "name": "UK Towns",
            "path": "/United Kingdom"
        },
        {
            "name": "UK Lakes",
            "path": "/United Kingdom"
        },
        {
            "name": "Welsh Lakes",
            "path": "/United Kingdom/Wales"
        },
        {
            "name": "Czech Ponds",
            "path": "/Czech Republic"
        },
        {
            "name": "Czech Villages",
            "path": "/Czech Republic"
        },
        {
            "name": "World Seas",
            "path": "/",
            "expanded": true
        }
    ]