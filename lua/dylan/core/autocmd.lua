local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local formatGroup = augroup("FormatGroup", { clear = true })

-- Add custom filetype for mdx files
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Disable new line comment
autocmd("BufEnter", {
  group = formatGroup,
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Remove trailing whitespace
autocmd("BufWritePre", {
  group = formatGroup,
  command = [[%s/\s\+$//e]],
  pattern = "*",
})

-- Enable spell checking on specific filetypes
autocmd("BufEnter", {
  group = augroup("SpellCheck", { clear = true }),
  pattern = { "*.md", "*.txt" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightOnYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Close loclist window on quit if buffer is empty
autocmd("QuitPre", {
  group = augroup("CloseLoclistWindowGroup", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd("lclose")
    end
  end,
})
