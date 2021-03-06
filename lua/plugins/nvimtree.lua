local M = {}

function M.setup()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end

    local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
    if not config_status_ok then
        return
    end

    local tree_cb = nvim_tree_config.nvim_tree_callback

    nvim_tree.setup {
        view = {
            side = "left",
            mappings = {
                list = {
                    -- { key = "a", action = "create" },
                    -- { key = "d", action = "remove" },
                    -- { key = "r", action = "rename" },
                    -- { key = "v", action = "vsplit" },
                    -- { key = "U", action = "dir_up" },
                    -- { key = "H", action = "toggl_dotfiles" },
                    -- { key = "?", action = "toggle_help" }

                    { key = "a", cb = tree_cb "create" },
                    { key = "d", cb = tree_cb "remove" },
                    { key = "r", cb = tree_cb "rename" },
                    { key = "U", cb = tree_cb "dir_up" },
                    { key = "H", cb = tree_cb "toggle_dotfiles" },
                    { key = "?", cb = tree_cb "toggle_help" },
                    { key = "v", cb = tree_cb "vsplit" }
                }
            }
        }
    }


end

return M
