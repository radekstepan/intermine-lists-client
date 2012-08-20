Chaplin = require 'chaplin'
Folder = require 'models/folder'

# A storage of all folders, resides in Store.
module.exports = class Folders extends Chaplin.Collection
    
    model: Folder

    data: [
        {
            "name": "UK Cities",
            "path": "/united-kingdom"
        },
        {
            "name": "UK Towns",
            "path": "/united-kingdom"
        },
        {
            "name": "UK Lakes",
            "path": "/united-kingdom"
        },
        {
            "name": "Welsh Lakes",
            "path": "/united-kingdom/wales"
        },
        {
            "name": "Czech Ponds",
            "path": "/czech-republic"
        },
        {
            "name": "Czech Villages",
            "path": "/czech-republic"
        },
        {
            "name": "World Seas",
            "path": "/",
            "expanded": true
        }
    ]