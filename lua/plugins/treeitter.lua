return {

	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"RRethy/nvim-treesitter-endwise",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("plugin-configs.treesitter").setup()
	end,
}
