-- return {
--     settings = {
--         typescript = {
--             -- https://www.npmjs.com/package/typescript-language-server#inlay-hints-textdocumentinlayhint
--             format = {
--                 indentSize = 4,
--             },
--             inlayHints = {
--                 includeInlayEnumMemberValueHints = true,
--                 includeInlayFunctionLikeReturnTypeHints = true,
--                 includeInlayFunctionParameterTypeHints = true,
--                 includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--                 includeInlayPropertyDeclarationTypeHints = true,
--                 includeInlayVariableTypeHints = true,
--                 includeInlayVariableTypeHintsWhenTypeMatchesName = true,
--             },
--         },
--     },
-- }

return {
    settings = {
        javascript = {
            format = {
                indentSize = 4,
            },
            inlayHints = {
                -- auto_inlay_hints = true,
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        typescript = {
            format = {
                indentSize = 4,
            },
            inlayHints = {
                -- auto_inlay_hints = true,
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    },
}
