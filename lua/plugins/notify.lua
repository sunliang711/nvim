return {

	"rcarriga/nvim-notify",
	priority = 35,
	config = function()
		require("plugin-configs.notify").setup()
	end,
}
