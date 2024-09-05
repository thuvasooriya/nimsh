local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

autocmd("TextYankPost", {
  desc = "highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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

-- create a user command for markdown preview
vim.api.nvim_create_user_command("MarkdownPreview", preview_markdown, {})

-- set up keybinding for markdown preview

vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })

-- optional: automatically set up for markdown files

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
  end,
})
-- local api = vim.api
-- local fn = vim.fn
--
-- local preview_group = api.nvim_create_augroup("MarkdownPreview", { clear = true })
-- local preview_job_id = nil
-- local preview_port = nil
--
-- local function get_random_port()
--   return math.random(10000, 65535)
-- end
--
-- local function start_server(port)
--   local preview_html = string.format(
--     [[
-- <!DOCTYPE html>
-- <html lang="en">
-- <head>
--     <meta charset="UTF-8">
--     <meta name="viewport" content="width=device-width, initial-scale=1.0">
--     <title>Markdown Preview</title>
--     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css">
--     <style>
--         .markdown-body {
--             box-sizing: border-box;
--             min-width: 200px;
--             max-width: 980px;
--             margin: 0 auto;
--             padding: 45px;
--         }
--     </style>
--     <script src="https://cdnjs.cloudflare.com/ajax/libs/marked/4.0.2/marked.min.js"></script>
-- </head>
-- <body>
--     <div id="content" class="markdown-body"></div>
--     <script>
--         const eventSource = new EventSource('/events');
--         eventSource.onmessage = function(event) {
--             document.getElementById('content').innerHTML = marked.parse(event.data);
--         };
--     </script>
-- </body>
-- </html>
--     ]],
--     port
--   )
--
--   local temp_dir = fn.tempname()
--   fn.mkdir(temp_dir, "p")
--   local preview_file = temp_dir .. "/preview.html"
--   local file = io.open(preview_file, "w")
--   file:write(preview_html)
--   file:close()
--
--   preview_job_id = fn.jobstart({ "python3", "-m", "http.server", tostring(port), "--directory", temp_dir }, {
--     on_exit = function()
--       preview_job_id = nil
--       preview_port = nil
--       fn.delete(temp_dir, "rf")
--     end,
--   })
-- end
--
-- local function update_preview()
--   if not preview_job_id then
--     return
--   end
--
--   local current_buf = api.nvim_get_current_buf()
--   local lines = api.nvim_buf_get_lines(current_buf, 0, -1, false)
--   local content = table.concat(lines, "\n")
--
--   -- Escape the content for use in a shell command
--   content = fn.shellescape(content)
--
--   -- Use curl to send a server-sent event
--   fn.jobstart(
--     string.format(
--       [[curl -X POST -H "Content-Type: text/event-stream" -d "data: %s" http://localhost:%d/events]],
--       content,
--       preview_port
--     )
--   )
-- end
--
-- local function preview_markdown()
--   if preview_job_id then
--     print "Preview is already running."
--     return
--   end
--
--   preview_port = get_random_port()
--   start_server(preview_port)
--
--   if preview_job_id then
--     api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--       group = preview_group,
--       buffer = api.nvim_get_current_buf(),
--       callback = update_preview,
--     })
--
--     -- Initial update
--     update_preview()
--
--     -- Open the preview in the default browser
--     fn.jobstart(string.format("open http://localhost:%d", preview_port))
--   else
--     print "Failed to start preview server."
--   end
-- end
--
-- local function stop_preview()
--   if preview_job_id then
--     fn.jobstop(preview_job_id)
--     preview_job_id = nil
--     preview_port = nil
--     api.nvim_clear_autocmds { group = preview_group }
--     print "Preview stopped."
--   else
--     print "No preview is running."
--   end
-- end
--
-- -- Create user commands for Markdown Preview
-- api.nvim_create_user_command("MarkdownPreview", preview_markdown, {})
-- api.nvim_create_user_command("MarkdownPreviewStop", stop_preview, {})
--
-- -- Set up keybindings for Markdown Preview
-- api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreview<CR>", { noremap = true, silent = true })
-- api.nvim_set_keymap("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { noremap = true, silent = true })
--
-- -- Optional: Automatically set up for Markdown files
-- api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     local opts = { noremap = true, silent = true }
--     api.nvim_buf_set_keymap(0, "n", "<leader>mp", ":MarkdownPreview<CR>", opts)
--     api.nvim_buf_set_keymap(0, "n", "<leader>ms", ":MarkdownPreviewStop<CR>", opts)
--   end,
-- })
