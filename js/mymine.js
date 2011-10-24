/**
 * InterMine MyMine Lists Page
 *
 * @copyright Copyright (c) 2011 InterMine
 * @license   http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @link      http://intermine.org
 * @category  InterMine
 */


var MyMine = (function() {


    /********************* Selectors *********************/


    /** @string selector for all folder names in the main table */
    var selectAllFolderNames  = 'table#lists tbody tr.folder h2.name',
    /** @string selector for all checked checkboxes in the main table */
        selectAllCheckedItems = 'table#lists tbody tr input[type="checkbox"].check:checked',
    /** @string selector for item name from main table row */
        selectRowToItemName   = 'h2.name';

    /** @string selector for main table */
    var selectMainTable        = 'table#lists',
    /** @string selector for all main table checkboxes */
        selectAllCheckboxes    = 'table#lists tbody tr input[type="checkbox"].check',
    /** @string selector for all main table rows */
        selectAllRows          = 'table#lists tbody tr',
    /** @string selector for toolbar buttons */
        selectToolbarButtons   = 'div#toolbar div.btn',
    /** @string selector for row checkbox from main table row */
        selectRowToCheckbox    = 'input[type="checkbox"].check',
    /** @string selector for all folder name links in the main table */
        selectAllFolderLinks   = 'table#lists tbody tr.folder td.main div.name a',
    /** @string selector for select all checkbox */
        selectSelectAll        = 'table#lists input[type="checkbox"].select-all';
    
    /** @string selector for all trashed lists table checkboxes */
    var selectTrashedListsCheckboxes = 'table#trash tbody tr input[type="checkbox"].check',
    /** @string selector for all trashed lists table rows */
        selectTrashedListsRows       = 'table#trash tbody tr',
    /** @string selector for select all checkbox on trashed lists */
        selectSelectAllTrashed       = 'table#trash input[type="checkbox"].select-all';

    /** @string selector for popup overlay */
    var selectPopupOverlay         = '#body-overlay',
    /** @string selector for popup window from overlay */
        selectPopupOverlayToWindow = 'div.popup',
    /** @string selector for popup window */
        selectPopupWindow          = '#body-overlay div.popup',
    /** @string selector for overlay popup close button */
        selectPopupCloseButton     = '#body-overlay div.btn.close';


    /********************* Initialize *********************/


    /**
     * Get all folders from the table after it was initialized
     * @XXX rewrite to fetch directly from source instead of parsing
     */
    function intitializeFolders() {
        $(selectAllFolderNames).each(function() {
            MyMine.model.addFolder($(this).text());
        });
    }

    /**
     * Attach appropriate classes to items that have been selected (and remembered) after reload
     * @XXX rewrite to fetch directly from source instead of parsing
     */
    function initializeSelectedItems() {
        $(selectAllCheckedItems).each(function() {
            var row = $(this).closest('tr');
            // set selected class
            row.addClass('selected');
            // set the item as selected internally
            MyMine.presenters.table.setAsSelectedItem(
                row.find(selectRowToItemName).text(),
                (row.hasClass('list')) ? 'list' : 'folder');
        });

        // based on selected items, update toolbar
        MyMine.presenters.table.updateToolbar();
    }

    /**
     * Get tags in the system available to be used
     * @XXX rewrite to fetch directly from source instead of parsing
     */
    function initializeTags() {
        $('#set-tags div.tags ul li').each(function() {
            var name = $(this).find('span.label').text();
            if (name) {
                MyMine.model.addTag(name);
            }
        })
    }

    return {

        /**
         * Initialize data after document is ready
         */
        init: function() {
            // initialize all folders
            intitializeFolders();

            // initialize selected items
            initializeSelectedItems();

            // initialize available tags
            initializeTags();

            // initialize presenters handlers
            MyMine.presenters.table.initializeHandlers();
            MyMine.presenters.folders.initializeHandlers();
            MyMine.presenters.tags.initializeHandlers();
            MyMine.presenters.trash.initializeHandlers();
        },
        



        /********************* Model *********************/




        'model': (function() {

            /** @dict internal 'folders' storage */
            var folders = {},
            /** @dict internal 'lists' storage */
                lists   = {},
            /** @dict internal available 'tags' storage */
                tags    = {};

            /** @string messages */
            var messageListExists = "Wowza! This list already exists.",
                messageTagExists  = "Wowza! That tag already exists.";

            return {

                /**
                 * Add a folder to an internal structure
                 * @throws
                 */
                addFolder: function(name) {
                    if (! MyMine.model.existsFolder(name)) {
                        folders[name] = true;
                    } else {
                        throw messageListExists;
                    }
                },

                /**
                 * Does the folder exist?
                 * @returns true if we have saved the folder name internally
                 */
                existsFolder: function(name) {
                    return folders[name];
                },

                /**
                 * Add a tag to an internal structure
                 * @throws
                 */
                addTag: function(name) {
                    if (! MyMine.model.existsTag(name)) {
                        tags[name] = true;
                    } else {
                        throw messageTagExists;
                    }
                },

                /**
                 * Does the tag exist?
                 * @returns true if we have saved the tag name internally
                 */
                existsTag: function(name) {
                    return tags[name];
                }
            };
        })(),


        'presenters': {




            /********************* Table Presenter *********************/
            



            'table': (function() {

                /** @dict selected item's name => type in the main table */
                var selected      = {},
                /** @int number of selected items in the main table */
                    selectedCount = 0;

                /**
                 * Initialize handlers for selecting items in the main table
                 */
                function initializeSelectItemHandlers() {
                    // on checkbox click
                    $(selectAllCheckboxes).click(function(e) {
                        MyMine.presenters.table.selectRow(this);
                        e.stopPropagation();
                    });

                    // on row select
                    $(selectAllRows).click(function(e) {
                        var checkbox = $(this).find(selectRowToCheckbox);
                        // first tick the checkbox
                        if (checkbox.attr('checked')) {
                            checkbox.attr('checked', false);
                        } else {
                            checkbox.attr('checked', 'checked');
                        }
                        MyMine.presenters.table.selectRow(checkbox);
                        e.stopPropagation();
                    });
                }

                /**
                 * Initialize handlers for expanding/collapsing of items
                 */
                function initializeExpandCollapseHandlers() {
                    // items
                    $(selectAllFolderLinks).click(function(e) {
                        MyMine.presenters.table.expandCollapseFolders(this);
                        e.stopPropagation();
                        e.preventDefault();
                    })
                }

                /**
                 * Select all handler
                 */
                function initializeSelectAllHandler() {
                    $(selectSelectAll).click(function() {
                        MyMine.presenters.table.selectAll(this);
                    })
                }

                /**
                 * Popup open/close handlers
                 */
                function initializePopupHandlers() {
                    // open on toolbar click
                    $(selectToolbarButtons).click(function() {
                        MyMine.presenters.table.openPopup(this);
                    });


                    // close button
                    $(selectPopupCloseButton).click(function() {
                        MyMine.presenters.table.closePopup();
                    });
                    // esc keypress
                    $(document).keyup(function(e) {
                        if (e.keyCode == 27) {
                            MyMine.presenters.table.closePopup();
                        }
                    });
                }

                return {

                    /**
                     * Initialize all the handlers
                     */
                    initializeHandlers: function() {
                        initializeSelectItemHandlers();
                        initializeExpandCollapseHandlers();
                        initializeSelectAllHandler();
                        initializePopupHandlers();
                    },

                    /**
                     * Set item in the main table as selected
                     */
                    setAsSelectedItem: function(name, type) {
                        selected[name] = type;
                        selectedCount++;
                    },

                    /**
                     * Add Folder/Organize lists switch
                     */
                    updateToolbar: function() {
                        if (selectedCount > 0) {
                            // organize lists
                            $(selectToolbarButtons + '.folder').hide();
                            $(selectToolbarButtons + '.organize').show();
                        } else {
                            // create folder
                            $(selectToolbarButtons + '.folder').show();
                            $(selectToolbarButtons + '.organize').hide();
                        }
                    },

                    /**
                     * Select row on checkbox or row click
                     */
                    selectRow: function(element) {
                        var row = $(element).closest('tr');
                        // folder?
                        if (row.hasClass('folder')) {
                            var inFolder = true;
                            if ($(element).is(':checked')) {
                                while (inFolder) {
                                    row = row.next();
                                    if (row.hasClass('list') && row.hasClass('foldered')) {
                                        if (! row.hasClass('selected')) {
                                            row.addClass('selected');
                                            row.find(selectRowToCheckbox).attr('checked', 'checked');
                                            selectedCount++;
                                        }
                                    } else {
                                        inFolder = false;
                                    }
                                }
                            } else {
                                while (inFolder) {
                                    row = row.next();
                                    if (row.hasClass('list') && row.hasClass('foldered')) {
                                        if (row.hasClass('selected')) {
                                            row.removeClass('selected');
                                            row.find(selectRowToCheckbox).attr('checked', false);
                                            selectedCount--;
                                        }
                                    } else {
                                        inFolder = false;
                                    }
                                }
                            }
                        } else {
                            if (! $(element).is(':checked')) {
                                row.removeClass('selected');
                                selectedCount--;
                            } else {
                                row.addClass('selected');
                                selectedCount++;
                            }
                        }

                        MyMine.presenters.table.updateToolbar();
                    },

                    selectAll: function(element) {
                        if ($(element).attr('checked')) {
                            $(selectAllRows).each(function() {
                                $(this).addClass('selected').find(selectRowToCheckbox).attr('checked', 'checked');
                            });
                        } else {
                            $(selectAllRows).each(function() {
                                $(this).removeClass('selected').find(selectRowToCheckbox).attr('checked', false);
                            });
                        }
                    },

                    /**
                     * Expand/collapse folders
                     */
                    expandCollapseFolders: function(element) {
                        var next = $(element).closest('tr').next();
                        if (next.hasClass('list') && next.hasClass('foldered')) {
                            // has children
                            var loop   = true,
                                hidden = next.is(':hidden');
                            // collapse
                            while (loop) {
                                if (hidden) {
                                    next.show();
                                } else {
                                    next.hide();
                                }

                                next = next.next();
                                if (! next.hasClass('list') || ! next.hasClass('foldered')) {
                                    loop = false;
                                }
                            }
                        }
                    },

                    /**
                     * Open up overlay popup
                     */
                    openPopup: function(element) {
                        $(selectPopupOverlay).show();
                        $(selectPopupWindow + '.' + $(element).attr('class').split(/\s+/)[1]).show();
                    },

                    /**
                     * Close overlay popup
                     */
                    closePopup: function() {
                        $(selectPopupOverlay).hide().find(selectPopupOverlayToWindow).hide();
                    }
                };
            })(),




            /********************* Folders Presenter *********************/
            



            'folders': (function() {

                /**
                 * Add a folder
                 */
                function initializeAddFolder() {
                    $(selectPopupWindow + '.folder input').keydown(function(e) {
                        if (e.keyCode == 13) {
                            MyMine.presenters.folders.addFolder();
                        }
                    });
                    $(selectPopupWindow + '.folder div.btn.add').click(function() {
                        MyMine.presenters.folders.addFolder();
                    });
                }

                return {

                    /**
                     * Initialize all the handlers
                     */
                    initializeHandlers: function() {
                        initializeAddFolder();
                    },

                    /**
                     * Create a new folder
                     */
                    addFolder: function() {
                        var name = $(selectPopupOverlayToWindow + '.folder input').val();
                        
                        if (name) {
                            try {
                                // call to model
                                MyMine.model.addFolder(name);

                                // add the new row
                                $('<tr/>', {
                                    'class': 'folder'
                                })
                                .append($('<td/>', {
                                    'class': 'first',
                                    'html': $('<input/>', {
                                        'type': 'checkbox',
                                        'class': 'check'
                                    })
                                }))
                                .append($('<td/>', {
                                    'class': 'second'
                                }))
                                .append($('<td/>', {
                                    'class': 'main',
                                    'html': $('<div/>', {
                                        'class': 'name',
                                        'html': $('<a/>', {
                                            'href': '#',
                                            'html': $('<h2/>', {
                                                'text': name
                                            })
                                        })
                                    })
                                }))
                                .append($('<td/>'))
                                .append($('<td/>'))
                                .append($('<td/>', {
                                    'class': 'datetime'
                                }))
                                .appendTo(selectMainTable);
                                
                                $(selectPopupOverlayToWindow + '.folder p.warning').text('');
                                $(selectPopupOverlayToWindow + '.folder input').val('')

                                $(selectPopupOverlay).hide().find('div.popup').hide();
                            } catch(message) {
                                $(selectPopupOverlayToWindow + '.folder p.warning').text(message);
                            }
                        }
                    }
                };
            })(),




            /********************* Tags Presenter *********************/
            



            'tags': (function() {

                /** @dict settings for jQuery UI Drag & Drop */
                var tagsDragDropSettings = {
                    'cursor': 'move',
                    'opacity': 0.5,
                    'revert': true,
                    'containment': selectPopupWindow + '.tags #set-tags'
                }

                /**
                 * Add a tag
                 */
                function initializeAddTag() {
                    $(selectPopupWindow + '.tags #add-new-tag input').keydown(function(e) {
                        if (e.keyCode == 13) {
                            MyMine.presenters.tags.addTag();
                        }
                    });
                    $(selectPopupWindow + '.tags #add-new-tag div.btn.add').click(function() {
                        MyMine.presenters.tags.addTag();
                    });
                }

                /**
                 * Remove tag
                 */
                function initializeRemoveTag() {
                    $(selectPopupWindow + '.tags div.tags ul li a span.remove').click(function() {
                        MyMine.presenters.tags.removeTag(this);
                    });
                }

                /**
                 * Initialize tags drag & drop
                 */
                function initializeTagsDragDrop() {
                    // drag & drop of tags
                    $(selectPopupWindow + '.tags ul.drag li').draggable(tagsDragDropSettings);
                    $(selectPopupWindow + '.tags div.dropzone').droppable({
                        'accept': selectPopupWindow + '.tags ul.drag li',
                        drop: function(event, ui) {
                            ui.draggable.appendTo(selectPopupWindow + '.tags div.dropzone div.tags ul')
                            .attr('style', 'left:0;top:0;')
                            .draggable('option', 'disabled', true)
                            .draggable('option', 'revert', false);
                        }
                    });
                }

                return {

                    /**
                     * Initialize all the handlers
                     */
                    initializeHandlers: function() {                        
                        initializeAddTag();
                        initializeRemoveTag();
                        initializeTagsDragDrop()
                    },

                    /**
                     * Create a new tag
                     */
                    addTag: function() {
                        var label = $(selectPopupWindow + '.tags #add-new-tag input').val();
                        if (label) {
                            try {
                                // try adding in the model
                                MyMine.model.addTag(label);

                                // actually add in the view
                                $('<li/>', {
                                    'html': function() {
                                       return $('<a/>')
                                       .append($('<span/>', {
                                           'class': 'label',
                                           'text': label
                                       }))
                                       .append($('<span/>', {
                                           'class': 'remove',
                                           'text': 'x'
                                       }))
                                    }
                                })
                                .appendTo(selectPopupWindow + '.tags #set-tags div.dropzone div.tags ul')
                                .click(function() {
                                    MyMine.presenters.tags.removeTag(this);
                                });

                                $(selectPopupWindow + '.tags #add-new-tag p.warning').html('');

                                $(selectPopupWindow + '.tags #add-new-tag input').val('')
                            } catch(message) {
                                $(selectPopupWindow + '.tags #add-new-tag p.warning').text(message);
                            }
                        }                    
                    },

                    /**
                     * Remove tag
                     */
                    removeTag: function(element) {
                        $(element).closest('li').appendTo(selectPopupWindow + '.tags div.tags.available ul')
                        .attr('style', 'position:relative')
                        .draggable(tagsDragDropSettings)
                        .draggable('option', 'disabled', false);
                    }
                };
            })(),




            /********************* Trash Presenter *********************/
            



            'trash': (function() {

                /**
                 * Initialize handlers for selecting items in the restore table
                 */
                function initializeSelectRestoreItemHandlers() {
                    // on checkbox click
                    $(selectTrashedListsCheckboxes).click(function(e) {
                        MyMine.presenters.trash.selectRow(this);
                        e.stopPropagation();
                    });

                    // on row select
                    $(selectTrashedListsRows).click(function(e) {
                        var checkbox = $(this).find(selectRowToCheckbox);
                        // first tick the checkbox
                        if (checkbox.attr('checked')) {
                            checkbox.attr('checked', false);
                        } else {
                            checkbox.attr('checked', 'checked');
                        }
                        MyMine.presenters.trash.selectRow(checkbox);
                        e.stopPropagation();
                    });
                }

                /**
                 * Select all handler
                 */
                function initializeSelectAllHandler() {
                    $(selectSelectAllTrashed).click(function() {
                        MyMine.presenters.trash.selectAll(this);
                    })
                }

                return {

                    /**
                     * Initialize all the handlers
                     */
                    initializeHandlers: function() {
                        initializeSelectRestoreItemHandlers();
                    },

                    /**
                     * Select a row in a trashed lists table
                     */
                    selectRow: function(element) {
                        alert('yay');
                        // XXX implement
                    },

                    /**
                     * Select all trashed lists
                     */
                    selectAll: function(element) {
                        // XXX implement
                    },
                };
            })()


        }
    };

})();