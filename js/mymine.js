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
    var selectAllFolderNames = 'table#lists tbody tr.folder h2.name';

    return {

        /**
         * Initialize data after document is ready
         */
        init: function() {
            // XXX get all the folders we have
            $(selectAllFolderNames).each(function() {
                MyMine.model.addFolder($(this).text());
            });
        },
        
        /********************* Model *********************/

        'model': (function() {

            /** @dict internal 'folders' storage */
            var folders = {};

            /** @string message */
            var messageListExists = "Wowza! This list already exists.";

            function privateAddFolder() {
                // do stuff here
            }

            return {

                /**
                 * Add a folder to an internal structure
                 * @throws
                 */
                addFolder: function(name) {
                    if (!MyMine.model.existsFolder(name)) {
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

            var private_var;

            function private_method() {
                // do stuff here
            }

            return {

                method_1: function() {
                    return "presenter first";
                },

                method_2: function() {
                    return "presenter second";
                }
            };
        })()
    };

})();