local M = {}

function M.setup()
    local PACKER_BOOTSTRAP = false

    local conf = {
        profile = {
            enable = true,
            threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    local function packer_init()
        local fn = vim.fn

        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        -- Automatically install packer
        if fn.empty(fn.glob(install_path)) > 0 then
            PACKER_BOOTSTRAP = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            print "Installing packer, close and reopen Neovim after installation !!"
            vim.cmd [[packadd packer.nvim]]
        end
        -- Autocommand that reloads neovim whenever you save the packer.lua file
        -- vim.cmd [[
        --   augroup packer_user_config
        --     autocmd!
        --     autocmd BufWritePost packer.lua source <afile> | PackerSync
        --   augroup end
        -- ]]

    end

    local function plugins(use)
        use "wbthomason/packer.nvim" -- Have packer manage itself

        local debug, all_settings = require "functions".merge_settings()
        -- print(vim.inspect(C))
        for _, setting in pairs(all_settings) do
            if type(setting) == "table" then
                if setting.enable then
                    if debug then
                        vim.notify("Pack load plugin " .. setting.name)
                    end
                    use(setting.packer_use)
                end
            end
        end

        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end

    packer_init()


    -- Use a protected call so we don't error out on first use
    local status_ok, packer = pcall(require, "packer")
    if not status_ok then
        return
    end

    -- Have packer use a popup window
    packer.init(conf)
    packer.startup(plugins)
end

return M
