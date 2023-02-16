return {

	"tpope/vim-surround",
	dependencise = {
		"tpope/vim-repeat",
	},
	config = function()
		require("plugin-configs.surround").setup()
	end,
}
