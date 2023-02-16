local M = {}

function M.setup()
	require("plugin-configs.lsp.lsp-signature")
	-- lsp-installer replaced by mason
	-- require("plugin-configs.lsp.lsp-installer")
	require("plugin-configs.lsp.mason").setup()
	require("plugin-configs.lsp.mason-lspconfig")
	require("plugin-configs.lsp.handlers").setup()
	require("plugin-configs.lsp.lspsaga").setup()
	-- require("plugin-configs.lsp.rust-tools").setup()

	require("plugin-configs.lsp.null-ls").setup()
	require("plugin-configs.lsp.fidget").setup()

	-- reference handlers.lua line 13
	-- require("plugin-configs.lsp.autoformat").autoformat()
end

return M
