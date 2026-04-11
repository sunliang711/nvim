local M = {}

local function get_config_path()
    return vim.fn.stdpath("config") .. "/lua/config.lua"
end

local function get_option_store(name)
    local ok, info = pcall(vim.api.nvim_get_option_info2, name, {})
    if ok then
        if info.scope == "win" then
            return vim.wo
        end

        if info.scope == "buf" then
            return vim.bo
        end

        return vim.o
    end

    local window_options = {
        wrap = true,
        relativenumber = true,
        cursorline = true,
        cursorcolumn = true,
        spell = true,
    }

    if window_options[name] then
        return vim.wo
    end

    return vim.o
end

function M.toggle_option(name)
    if type(name) ~= "string" or name == "" then
        vim.notify("Invalid option name", vim.log.levels.ERROR)
        return
    end

    local store = get_option_store(name)
    local ok, value = pcall(function()
        return store[name]
    end)

    if not ok then
        vim.notify(string.format("Unknown option: %s", name), vim.log.levels.ERROR)
        return
    end

    if type(value) ~= "boolean" then
        vim.notify(string.format("Option is not boolean: %s", name), vim.log.levels.ERROR)
        return
    end

    store[name] = not value
end

function M.open_plugin_config()
    vim.cmd("edit " .. vim.fn.fnameescape(get_config_path()))
end

function M.reload_plugin_config()
    local config_path = get_config_path()
    local ok, err = pcall(dofile, config_path)
    if not ok then
        vim.notify(string.format("Reload config.lua failed: %s", err), vim.log.levels.ERROR)
        return
    end

    vim.schedule(function()
        local config_ok, lazy_config = pcall(require, "lazy.core.config")
        local plugin_ok, plugin_loader = pcall(require, "lazy.core.plugin")
        local handler_ok, handler = pcall(require, "lazy.core.handler")
        local loader_ok, loader = pcall(require, "lazy.core.loader")
        if not (config_ok and plugin_ok and handler_ok and loader_ok) then
            vim.notify("config.lua reloaded", vim.log.levels.INFO)
            return
        end

        if lazy_config.options == nil or lazy_config.options.pkg == nil then
            vim.notify("config.lua reloaded, restart Neovim if plugin switches did not fully apply", vim.log.levels.WARN)
            return
        end

        local old_plugins = {}
        for name, plugin in pairs(lazy_config.plugins or {}) do
            old_plugins[name] = plugin
        end

        -- 重新解析 plugin spec，让 enabled/cond 使用最新的 PLUGINS 配置
        plugin_loader.load()

        -- 重新挂载 lazy handlers，让新启用的 lazy 插件接管 keys/cmd/event
        handler.setup()

        local disabled_plugins = {}
        for name, _ in pairs(old_plugins) do
            if lazy_config.plugins[name] == nil then
                table.insert(disabled_plugins, name)
            end
        end

        for _, plugin in pairs(lazy_config.plugins or {}) do
            if plugin.name ~= "lazy.nvim" and old_plugins[plugin.name] == nil and plugin.lazy == false then
                loader.load(plugin, { start = "config.lua" })
            end
        end

        if #disabled_plugins > 0 then
            vim.notify(
                "config.lua reloaded, restart Neovim to fully disable: " .. table.concat(disabled_plugins, ", "),
                vim.log.levels.WARN
            )
            return
        end

        vim.notify("config.lua reloaded", vim.log.levels.INFO)
    end)
end

return M
