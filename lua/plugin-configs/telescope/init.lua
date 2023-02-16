local M = {}

function M.setup()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
        return
    end

    local status_actions, actions = pcall(require, "telescope.actions")
    if not status_actions then
        return
    end

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                }
            }
        }
    })

end

return M
