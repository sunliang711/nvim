return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
-- local sumneko_binary_path = vim.fn.exepath('lua-language-server')
-- local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')
--
-- return {
--     settings = {
--         cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
--         Lua = {
--             -- type = {
--             --     weakUnionCheck = true,
--             --     weakNilCheck = true,
--             --     castNumberToInteger = true,
--             -- },
--             format = {
--                 enable = true,
--             },
--             hint = {
--                 enable = true,
--                 arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
--                 await = true,
--                 paramName = "Disable", -- "All", "Literal", "Disable"
--                 paramType = false,
--                 semicolon = "Disable", -- "All", "SameLine", "Disable"
--                 setType = true,
--             },
--             -- spell = {"the"}
--             runtime = {
--                 version = "LuaJIT",
--                 special = {
--                     reload = "require",
--                 },
--             },
--             diagnostics = {
--                 globals = { "vim" },
--             },
--             workspace = {
--                 library = {
--                     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--                     [vim.fn.stdpath "config" .. "/lua"] = true,
--                     -- [vim.fn.datapath "config" .. "/lua"] = true,
--                 },
--             },
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }
