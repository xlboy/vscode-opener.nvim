local M = {}

local config = { notify = true }

local notify = function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = "vscode-opener.nvim" })
end

local function launch(opts)
  local cmd_prefix = "code -g "
  local cmd_args = ""

  if not opts.filenames or #opts.filenames == 0 then
    cmd_args = opts.cwd
  else
    cmd_args = opts.cwd .. " " .. table.concat(opts.filenames, " ")
  end

  local cmd = cmd_prefix .. " " .. cmd_args
  vim.fn.system(cmd)
end

function M.setup(opts)
  config = vim.tbl_extend("force", config, opts or {})
end

M.open_cwd = function()
  local cwd = vim.fn.getcwd()
  launch({ cwd = cwd })

  if config.notify then notify("Opened `" .. cwd .. "` in VSCode") end
end

M.open_current_buf = function(opts)
  opts = vim.tbl_extend("force", {
    cwd = true, -- Open in current working directory
  }, opts or {})

  local filename = vim.fn.expand("%:p")
  local filename_with_loc = string.format("%s:%s:%s", filename, unpack(vim.api.nvim_win_get_cursor(0)))

  local cwd = opts.cwd and vim.fn.getcwd() or ""

  launch({ cwd = cwd, filenames = { filename_with_loc } })

  if config.notify then
    if opts.cwd then
      local relative_filename = vim.fn.fnamemodify(filename, ":~:.")
      notify("Opened `" .. relative_filename .. "` in VSCode")
    else
      notify("Opened `" .. filename .. "` in VSCode")
    end
  end
end

M.open_all_bufs = function()
  local filenames = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local filename = vim.api.nvim_buf_get_name(bufnr)

    local is_valid = vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and filename ~= ""
    if not is_valid then goto continue end

    local is_current_buf = bufnr == vim.api.nvim_get_current_buf()
    if is_current_buf then
      local cursor = vim.api.nvim_win_get_cursor(0)
      filename = string.format("%s:%s:%s", filename, cursor[1], cursor[2])
    end

    table.insert(filenames, filename)

    ::continue::
  end

  launch({ cwd = vim.fn.getcwd(), filenames = filenames })

  if config.notify then notify("Opened all buffers in VSCode") end
end

M.open = function()
  local function gen_cmd(fn)
    return "lua require('vscode-opener')." .. fn
  end

  local items = {
    ["Current Buffer"] = gen_cmd("open_current_buf()"),
    ["Current Buffer (No CWD)"] = gen_cmd("open_current_buf({ cwd = false })"),
    ["Current Working Directory"] = gen_cmd("open_cwd()"),
    ["All Buffers"] = gen_cmd("open_all_bufs()"),
  }
  local labels = vim.tbl_keys(items)

  vim.ui.select(labels, { prompt = "[VSCode Opener] Select Mode" }, function(label)
    if not label then return end

    local cmd = items[label]
    vim.cmd(cmd)
  end)
end

return M
