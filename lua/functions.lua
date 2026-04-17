local M = {}

local function get_config_path()
    return vim.fn.stdpath("config") .. "/lua/config.lua"
end

local function get_current_buffer_path()
    local path = vim.api.nvim_buf_get_name(0)
    if path == nil or path == "" then
        return vim.fn.getcwd()
    end

    return vim.fn.fnamemodify(path, ":p")
end

local function get_project_root(path)
    local absolute_path = path
    if absolute_path == nil or absolute_path == "" then
        absolute_path = get_current_buffer_path()
    end

    if vim.fn.isdirectory(absolute_path) ~= 1 then
        absolute_path = vim.fn.fnamemodify(absolute_path, ":h")
    end

    -- 优先向上查找 Git 根目录，找不到时回退到当前文件所在目录。
    local git_dir = vim.fs.find(".git", {
        path = absolute_path,
        upward = true,
        limit = 1,
    })[1]

    if git_dir ~= nil then
        return vim.fs.dirname(git_dir)
    end

    return absolute_path
end

local function set_cwd_to_project_root(path)
    local project_root = get_project_root(path)
    if project_root == nil or project_root == "" then
        return nil
    end

    local current_cwd = vim.fn.getcwd()
    if current_cwd ~= project_root then
        -- 让 nvim-tree 后续的 update_root 优先使用项目根目录。
        vim.cmd("cd " .. vim.fn.fnameescape(project_root))
    end

    return project_root
end

local function get_telescope_search_state()
    if vim.g.telescope_search_hidden == nil then
        vim.g.telescope_search_hidden = false
    end

    if vim.g.telescope_search_no_ignore == nil then
        vim.g.telescope_search_no_ignore = false
    end

    return {
        hidden = vim.g.telescope_search_hidden,
        no_ignore = vim.g.telescope_search_no_ignore,
    }
end

local function extend_telescope_additional_args(opts, extra_args)
    if #extra_args == 0 then
        return opts
    end

    local original = opts.additional_args
    opts.additional_args = function(prompt)
        local args = vim.deepcopy(extra_args)

        if type(original) == "function" then
            local original_args = original(prompt)
            if type(original_args) == "table" then
                vim.list_extend(args, original_args)
            end
        elseif type(original) == "table" then
            vim.list_extend(args, original)
        end

        return args
    end

    return opts
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

function M.toggle_telescope_hidden()
    local next_state = not get_telescope_search_state().hidden
    vim.g.telescope_search_hidden = next_state

    if next_state then
        vim.notify("telescope hidden files shown", vim.log.levels.INFO)
        return
    end

    vim.notify("telescope hidden files hidden", vim.log.levels.INFO)
end

function M.toggle_telescope_no_ignore()
    local next_state = not get_telescope_search_state().no_ignore
    vim.g.telescope_search_no_ignore = next_state

    if next_state then
        vim.notify("telescope gitignored files shown", vim.log.levels.INFO)
        return
    end

    vim.notify("telescope gitignored files hidden", vim.log.levels.INFO)
end

function M.telescope_find_files(opts)
    local builtin_ok, builtin = pcall(require, "telescope.builtin")
    if not builtin_ok then
        vim.notify("telescope is not ready", vim.log.levels.ERROR)
        return
    end

    local state = get_telescope_search_state()
    local final_opts = vim.tbl_deep_extend("force", opts or {}, {
        hidden = state.hidden,
        no_ignore = state.no_ignore,
    })

    builtin.find_files(final_opts)
end

function M.telescope_live_grep(opts)
    local builtin_ok, builtin = pcall(require, "telescope.builtin")
    if not builtin_ok then
        vim.notify("telescope is not ready", vim.log.levels.ERROR)
        return
    end

    local state = get_telescope_search_state()
    local rg_args = {}
    local final_opts = vim.tbl_deep_extend("force", {}, opts or {})

    if state.hidden then
        table.insert(rg_args, "--hidden")
    end

    if state.no_ignore then
        table.insert(rg_args, "--no-ignore")
    end

    extend_telescope_additional_args(final_opts, rg_args)
    builtin.live_grep(final_opts)
end

function M.open_plugin_config()
    vim.cmd("edit " .. vim.fn.fnameescape(get_config_path()))
end

function M.toggle_nvimtree_project_root()
    local api_ok, api = pcall(require, "nvim-tree.api")
    if not api_ok then
        vim.notify("nvim-tree is not ready", vim.log.levels.ERROR)
        return
    end

    if api.tree.is_visible() then
        api.tree.close()
        return
    end

    local project_root = set_cwd_to_project_root()
    api.tree.open({
        path = project_root,
        find_file = true,
        update_root = true,
        focus = true,
    })
end

function M.find_file_in_nvimtree_project_root()
    local api_ok, api = pcall(require, "nvim-tree.api")
    if not api_ok then
        vim.notify("nvim-tree is not ready", vim.log.levels.ERROR)
        return
    end

    set_cwd_to_project_root()
    api.tree.find_file({
        open = true,
        update_root = true,
        focus = true,
    })
end

function M.toggle_nvimtree_gitignore()
    local config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
    if not config_ok or nvim_tree_config.g == nil or nvim_tree_config.g.filters == nil then
        vim.notify("nvim-tree is not ready", vim.log.levels.ERROR)
        return
    end

    local api_ok, api = pcall(require, "nvim-tree.api")
    local core_ok, core = pcall(require, "nvim-tree.core")
    local explorer = nil
    local visible = false

    if api_ok then
        visible = api.tree.is_visible()
    end

    if core_ok then
        explorer = core.get_explorer()
    end

    local current = nvim_tree_config.g.filters.git_ignored
    if explorer ~= nil and explorer.filters ~= nil and explorer.filters.state ~= nil then
        current = explorer.filters.state.git_ignored
    end

    local next_state = not current
    nvim_tree_config.g.filters.git_ignored = next_state

    if explorer ~= nil and explorer.filters ~= nil and explorer.filters.state ~= nil then
        explorer.filters.state.git_ignored = next_state

        if visible then
            local node = explorer:get_node_at_cursor()
            explorer:reload_explorer()
            if node ~= nil then
                explorer:focus_node_or_parent(node)
            end
        end
    end

    if next_state then
        vim.notify("nvim-tree gitignored files hidden", vim.log.levels.INFO)
        return
    end

    vim.notify("nvim-tree gitignored files shown", vim.log.levels.INFO)
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
