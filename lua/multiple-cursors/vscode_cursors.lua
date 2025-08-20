local M = {}

local virtual_cursors = require("multiple-cursors.virtual_cursors")

function M.sync_all_cursors_to_vscode()
  if vim.g.vscode then
    local vscode = require("vscode")
    local ranges = {}

    virtual_cursors.visit_all_ignore_lock(function(vc)
      local range = {
        start = { line = vc.lnum - 1, character = vc.col },
        ["end"] = { line = vc.lnum - 1, character = vc.col },
      }
      table.insert(ranges, range)
    end)

    local pos = vim.fn.getcurpos()
    local range = {
      start = { line = pos[2] - 1, character = pos[3] },
      ["end"] = { line = pos[2] - 1, character = pos[3] },
    }
    table.insert(ranges, range)

    vscode.action("start-multiple-cursors", { args = { ranges } })
  end
end

return M
