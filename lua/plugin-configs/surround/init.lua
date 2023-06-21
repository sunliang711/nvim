local M = {}

function M.setup()
    local status_ok, surround = pcall(require, "surround")
    if not status_ok then
        return
    end

    surround.setup {
        context_offset = 100,
        load_autogroups = false,
        mappings_style = "surround",
        map_insert_mode = true,
        quotes = { "'", '"' },
        brackets = { "(", '{', '[' },
        pairs = {
            nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
            linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } }
        },
        prefix = "s"
    }

    local status_repeat, rep = pcall(require, "repeat")
    if not status_repeat then
        return
    end

    rep.setup()
end

return M
