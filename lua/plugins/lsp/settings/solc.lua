-- targets can be one of ewasm, generic, sabre, solana, substrate

local status, util = pcall(require, 'lspconfig.util')
if not status then
    return
end


return {
    -- cmd = { "solc", "--lsp", "--import-path", "node_modules" },
    cmd = { "solc", "--lsp", "--include-path", "../node_modules" },

    root_dir = function(fname)
        return util.root_pattern(".git")(fname) or util.root_pattern("hardhat.config.js")(fname);
    end
}
