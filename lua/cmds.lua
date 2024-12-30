local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

usercmd("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "disable autoformat-on-save",
  bang = true,
})

usercmd("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "re-enable autoformat-on-save",
})

-- autocmd("TextYankPost", {
--   desc = "highlight when yanking (copying) text",
--   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
--   callback = function()
--     vim.hl.on_yank()
--   end,
-- })

local function escape_shell_arg(arg)
  return "'" .. string.gsub(arg, "'", "'\\''") .. "'"
end

local function preview_markdown()
  local current_buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
  local content = table.concat(lines, "\n")

  -- Create a temporary HTML file
  local tmp_file = os.tmpname() .. ".html"
  local html_content = [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>md preview</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css">
    <style>
        .markdown-body {
            box-sizing: border-box;
            min-width: 200px;
            max-width: 980px;
            margin: 0 auto;
            padding: 45px;
        }

        body {
            margin : 0;
            padding : 0;
        }
    </style>
</head>
<body>
    <div class="markdown-body">
        <!-- markdown content will be inserted here -->
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/marked/4.0.2/marked.min.js"></script>
    <script>
        const content = ]] .. vim.json.encode(content) .. [[;
        document.querySelector('.markdown-body').innerHTML = marked.parse(content);
    </script>
</body>
</html>
    ]]

  local file = io.open(tmp_file, "w")
  file:write(html_content)
  file:close()

  -- open the html file in the default browser
  local open_cmd
  if vim.fn.has "mac" == 1 then
    open_cmd = "open"
  elseif vim.fn.has "unix" == 1 then
    open_cmd = "xdg-open"
  elseif vim.fn.has "win32" == 1 then
    open_cmd = "start"
  else
    print "unsupported operating system"
    return
  end

  local cmd = string.format("%s %s", open_cmd, escape_shell_arg(tmp_file))
  vim.fn.system(cmd)
end

usercmd("MarkdownPreview", preview_markdown, {})

-- set up keybinding for markdown preview

-- vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })

-- optional: automatically set up for markdown files

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
  end,
})
