local M = {}

local extmarks = require("multiple-cursors.extmarks")
local virtual_cursors = require("multiple-cursors.virtual_cursors")

local VirtualCursor = require("multiple-cursors.virtual_cursor")

function M.sync_all_cursors_to_vscode()
  if vim.g.vscode then
    local vscode = require("vscode")
    local ranges = {}
    local offset = -1

    virtual_cursors.visit_all(function(vc)
      table.insert(ranges, vc:to_range(offset))
    end)

    local curpos = VirtualCursor:new()
    curpos:save_cursor_position()
    table.insert(ranges, curpos:to_range(offset))

    vscode.action("start-multiple-cursors", { args = { ranges } })

    virtual_cursors.clear()
    extmarks.clear()
  end
end

return M
