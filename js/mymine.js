/**
 * InterMine MyMine Lists Page
 *
 * @copyright Copyright (c) 2011 InterMine
 * @license   http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @link      http://intermine.org
 * @category  InterMine
 */


var MyMine = (function() {

    /** @string selector for all folder names in the main table */
    var selectAllFolderNames  = 'table#lists tbody tr.folder h2.name',
    /** @string selector for all checked checkboxes in the main table */
        selectAllCheckedItems = 'table#lists tbody tr input[type="checkbox"].check:checked',
    /** @string selector for item name from main table row */
        selectRowToItemName   = 'h2.name';

    /**
     * Get all folders from the table after it was initialized
     * @XXX rewrite to fetch directly from source instead of parsing
     */
    function privateIntitializeFolders() {
        $(selectAllFolderNames).each(function() {
            MyMine.model.addFolder($(this).text());
        });
    }

    /**
     * Attach appropriate classes to items that have been selected (and remembered) after reload
     * @XXX rewrite to fetch directly from source instead of parsing
     */
    function privateInitilizeSelectedItems() {
        $(selectAllCheckedItems).each(function() {
            var row = $(this).closest('tr');
            // set selected class
            row.addClass('selected');
            // set the item as selected internally
            MyMine.presenter.setAsSelectedItem(
                row.find(selectRowToItemName).text(),
                (row.hasClass('list')) ? 'list' : 'folder');
        });

        // based on selected items, update toolbar
        MyMine.presenter.updateToolbar();
    }

    return {

        /**
         * Initialize data after document is ready
         */
        init: function() {
            // initialize all folders
            privateIntitializeFolders();

            // initialize selected items
            privateInitilizeSelectedItems();

            // initialize item selection handlers
            MyMine.presenter.initializeHandlers();
        },
        
        /********************* Model *********************/

        'model': (function() {

            /** @dict internal 'folders' storage */
            var folders = {};

            /** @dict internal 'lists' storage */
            var lists = {};

            /** @string messages */
            var messageListExists = "Wowza! This list already exists.";

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
                }
            };
        })(),


        /********************* Presenter *********************/


        'presenter': (function() {

            /** @string selector for toolbar buttons */
            var selectToolbarButtons   = 'div#toolbar div.btn',
            /** @string selector for all main table checkboxes */
                selectAllCheckboxes    = 'table#lists tbody tr input[type="checkbox"].check',
            /** @string selector for all main table rows */
                selectAllRows          = 'table#lists tbody tr',
            /** @string selector for row checkbox from main table row */
                selectRowToCheckbox    = 'input[type="checkbox"].check',
            /** @string selector for all folder name links in the main table */
                selectAllFolderLinks   = 'table#lists tbody tr.folder td.main div.name a',
            /** @string selector for select all checkbox */
                selectSelectAll        = 'input[type="checkbox"].select-all';
            
            /** @string selector for popup overlay */
            var selectPopupOverlay         = '#body-overlay',
            /** @string selector for popup window from overlay */
                selectPopupOverlayToWindow = 'div.popup',
            /** @string selector for popup window */
                selectPopupWindow          = '#body-overlay div.popup',
            /** @string selector for overlay popup close button */
                selectPopupCloseButton     = '#body-overlay div.btn.close';

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
                    MyMine.presenter.selectRow(this);
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
                    MyMine.presenter.selectRow(checkbox);
                    e.stopPropagation();
                });
            }

            /**
             * Initialize handlers for expanding/collapsing of items
             */
            function initializeExpandCollapseHandlers() {
                // items
                $(selectAllFolderLinks).click(function(e) {
                    MyMine.presenter.expandCollapseFolders(this);
                    e.stopPropagation();
                    e.preventDefault();
                })
            }

            /**
             * Select all handler
             */
            function initializeSelectAllHandler() {
                $(selectSelectAll).click(function() {
                    MyMine.presenter.selectAll(this);
                })
            }

            function initializePopupHandlers() {
                // open on toolbar click
                $(selectToolbarButtons).click(function() {
                    MyMine.presenter.openPopup(this);
                });


                // close button
                $(selectPopupCloseButton).click(function() {
                    MyMine.presenter.closePopup();
                });
                // esc keypress
                $(document).keyup(function(e) {
                    if (e.keyCode == 27) {
                        MyMine.presenter.closePopup();
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

                    MyMine.presenter.updateToolbar();
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
        })()
    };

})();