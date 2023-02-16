return {
	"akinsho/bufferline.nvim",
	version = "v2.*",
	dependencies = "kyazdani42/nvim-web-devicons",
	config = function()
		require("plugin-configs.bufferline").setup()
	end,
}
