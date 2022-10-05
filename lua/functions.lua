local M = {}

vim.cmd [[
  function Test()
    %SnipRun
    call feedkeys("\<esc>`.")
  endfunction
  function TestI()
    let b:caret = winsaveview()    
    %SnipRun
    call winrestview(b:caret)
  endfunction
]]

function M.sniprun_enable()
    vim.cmd [[
    %SnipRun
    augroup _sniprun
     autocmd!
     autocmd TextChanged * call Test()
     autocmd TextChangedI * call TestI()
    augroup end
  ]]
    vim.notify "Enabled SnipRun"
end

function M.disable_sniprun()
    M.remove_augroup "_sniprun"
    vim.cmd [[
    SnipClose
    SnipTerminate
    ]]
    vim.notify "Disabled SnipRun"
end

function M.toggle_sniprun()
    if vim.fn.exists "#_sniprun#TextChanged" == 0 then
        M.sniprun_enable()
    else
        M.disable_sniprun()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd [[ command! SnipRunToggle execute 'lua require("user.functions").toggle_sniprun()' ]]

-- get length of current word
function M.get_word_length()
    local word = vim.fn.expand "<cword>"
    return #word
end

function M.toggle_option(option)
    local value = not vim.api.nvim_get_option_value(option, {})
    vim.opt[option] = value
    vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
    local value = vim.api.nvim_get_option_value("showtabline", {})

    if value == 2 then
        value = 0
    else
        value = 2
    end

    vim.opt.showtabline = value

    vim.notify("showtabline" .. " set to " .. tostring(value))
end

local diagnostics_active = true
function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

function M.isempty(s)
    return s == nil or s == ""
end

function M.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end

function M.smart_quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if modified then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd "q!"
            end
        end)
    else
        vim.cmd "q!"
    end
end

function M.save_all()
    vim.cmd "wall"
    vim.notify({ "All Files Saved" }, "info", { timeout = 1000 })
end

M.default_config_file = "plugins_config_default"
M.user_config_file = "plugins_config_user"

-- TODO
function M.config_plugin()
    local status_ok, settings_user = pcall(require, M.user_config_file)
    if not status_ok then
        local copy_cmd = "cp " .. M.default_config_file .. " " .. M.user_config_file
        vim.fn.system(copy_cmd)
    end
    vim.cmd("edit " .. M.user_config_file)
end

function M.merge_settings()
    local settings_default = require(M.default_config_file)

    local status_ok, settings_user = pcall(require, M.user_config_file)
    if status_ok then
        -- "force": use value from the rightmost map
        settings_default = vim.tbl_deep_extend("force", settings_default, settings_user)
    end

    -- transfrom table1 to table2 (table2 can sort by order)
    -- table1 format { plugin1=>{}, plugin2=>{}}
    -- table2 format { {plugin1}, {plugin2}}
    local all_settings = {}
    for plugin_name, setting in pairs(settings_default) do
        if type(setting) == 'table' then
            setting['name'] = plugin_name
            table.insert(all_settings, setting)
        end
    end
    table.sort(all_settings, M.compare_by_order)

    return settings_default.debug, all_settings
end

function M.compare_by_order(a, b)
    return a['load_order'] < b['load_order']
end

function M.load_plugins()
    local debug, all_settings = M.merge_settings()

    -- Debug
    -- print(vim.inspect(all_settings))

    for _, setting in pairs(all_settings) do
        if type(setting) == "table" then
            -- for debug
            -- print("type:" .. type(setting))
            -- print("load " .. plugin_name)
            -- print("setting: " .. vim.inspect(setting))
            if setting.enable then
                if debug then
                    vim.notify("Load plugin config: " .. setting.name)
                end
                require(setting.config_module_path).setup()
            end
        end
    end

    if debug then
        vim.notify("All plugins loaded", "info")
    end
end

return M
