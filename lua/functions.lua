local M = {}

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

return M
