-- local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local FloatingTerminal = {
  state = {
    buf = nil,
    win = nil,
  },
}

-- Create a floating window with a terminal
function FloatingTerminal:open(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Use existing buffer if valid, otherwise create a new one
  local buf = self.state.buf
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    buf = vim.api.nvim_create_buf(false, true)
    self.state.buf = buf
  end

  -- Create the floating window
  self.state.win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  })

  -- Ensure the buffer is set to terminal mode
  if vim.bo[buf].buftype ~= "terminal" then
    vim.cmd.terminal()
  end

  vim.cmd.startinsert()
end

-- Toggle the floating terminal
function FloatingTerminal:toggle()
  if self.state.win and vim.api.nvim_win_is_valid(self.state.win) then
    vim.api.nvim_win_hide(self.state.win)
    self.state.win = nil
  else
    self:open()
  end
end

usercmd("Fterm", function()
  FloatingTerminal:toggle()
end, {})
