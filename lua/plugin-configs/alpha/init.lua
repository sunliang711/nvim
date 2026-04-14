local M = {}

function M.setup()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local icons = require("icons")

	local dashboard = require("alpha.themes.dashboard")
	local use_telescope = PLUGINS.telescope == nil or PLUGINS.telescope.enabled ~= false
	local use_auto_session = PLUGINS.auto_session == nil or PLUGINS.auto_session.enabled ~= false
	-- local dashboard = require "alpha.themes.startify"
	dashboard.section.header.val = {
		[[                               __                ]],
		[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}
	local buttons = {}
	-- telescope 关闭时移除相关入口，避免 dashboard 调用不存在的命令
	if use_telescope then
		table.insert(
			buttons,
			dashboard.button("f", icons.documents.Files .. " Find file", ':lua require("functions").telescope_find_files() <CR>')
		)
	end
	table.insert(buttons, dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"))
	if use_auto_session then
		table.insert(buttons, dashboard.button("s", icons.ui.SignIn .. " Find session", ":AutoSession search <CR>"))
	end
	if use_telescope then
		table.insert(buttons, dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"))
		table.insert(
			buttons,
			dashboard.button("t", icons.ui.List .. " Find text", ':lua require("functions").telescope_live_grep() <CR>')
		)
	end
	table.insert(buttons, dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"))
	table.insert(buttons, dashboard.button("u", icons.ui.CloudDownload .. " Update", ":Lazy sync<CR>"))
	table.insert(buttons, dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"))
	dashboard.section.buttons.val = buttons
	local function footer()
		-- NOTE: requires the fortune-mod package to work
		-- local handle = io.popen("fortune")
		-- local fortune = handle:read("*a")
		-- handle:close()
		-- return fortune
		return "Enjoy Nvim"
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	dashboard.opts.opts.noautocmd = true
	-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
	alpha.setup(dashboard.opts)
end

return M
