local F = require "functions"
local C = require "pluginloader"
require "options"
require "keymaps"
require "autocmds"


-- load plugin manager: packer
require "plugins"

F.load_plugin_config( "impatient" )
F.load_plugin_config( "notify" )
F.load_plugin_config( "treesitter" )
F.load_plugin_config( "cmp" )
F.load_plugin_config( "alpha" )
F.load_plugin_config( "surround" )
F.load_plugin_config( "nvimtree" )
F.load_plugin_config( "neoscroll" )
F.load_plugin_config( "colorscheme" )
F.load_plugin_config( "bufferline" )
F.load_plugin_config( "gitsigns" )
F.load_plugin_config( "toggleterm" )
F.load_plugin_config( "comment" )
F.load_plugin_config( "whichkey" )



vim.notify("all plugins loaded","info")
