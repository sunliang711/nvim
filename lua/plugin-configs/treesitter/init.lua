local M = {}

function M.setup()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end

    configs.setup({
        -- ensure_installed = "all", -- one of "all" or a list of languages
        -- reference https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        ensure_installed = {
            "c", "cpp",
            "css", "html",
            "javascript", "jsdoc",

            "json",
            "toml",
            "yaml",

            "lua",
            "vim",
            "make",
            "markdown",
            "regex",
            "go",
            "rust",

            "markdown",
            "markdown_inline"
        },
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
            -- use_languagetree = true,
            enable = true, -- false will disable the whole extension
            -- disable = { "css", "html" }, -- list of language that will be disabled
            -- additional_vim_regex_highlighting = true,
        },
        autopairs = {
            enable = true,
        },
        indent = {
            enable = true,
            disable = { "css" }
        },
        autotag = {
            enable = true,
            disable = { "xml" },
        },
        endwise = {
            enable = true,
        }
    })
end

return M
