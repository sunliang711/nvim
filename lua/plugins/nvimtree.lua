local enabled = PLUGINS.nvimtree == nil or PLUGINS.nvimtree.enabled ~= false

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{ "<leader>fe", '<cmd>lua require("functions").toggle_nvimtree_project_root()<cr>', desc = "File Explorer" },
		{ "<leader>e", '<cmd>lua require("functions").toggle_nvimtree_project_root()<cr>', desc = "File Explorer" },
	},
	config = function()
		require("plugin-configs.nvimtree").setup()
	end,
	enabled = enabled,
	cond = enabled,
}
