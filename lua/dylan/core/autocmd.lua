local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local formatGroup = augroup("FormatGroup", { clear = true })
local spellCheckGroup = augroup("SpellCheck", { clear = true })
local yankHighlightGroup = augroup("HighlightOnYank", { clear = true })
local locListGroup = augroup("CloseLoclistWindowGroup", { clear = true })
--
-- -- Add custom filetype for mdx files
-- vim.filetype.add({
--   extension = { mdx = "mdx" },
-- })

-- Remove new line comments
autocmd("BufEnter", {
  group = formatGroup,
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = formatGroup,
  command = [[%s/\s\+$//e]],
  pattern = "*",
})

-- Enable spell checking for markdown and text files
autocmd("BufEnter", {
  group = spellCheckGroup,
  pattern = { "*.md", "*.txt" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Highlight text on yank
autocmd("TextYankPost", {
  group = yankHighlightGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})

-- Close loclist window on quit if buffer is empty
autocmd("QuitPre", {
  group = locListGroup,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd("lclose")
    end
  end,
})

-- Open oil.nvim if Neovim is launched with a directory as an argument
autocmd("VimEnter", {
  callback = function()
    local first_arg = vim.v.argv[3]
    if first_arg and vim.fn.isdirectory(first_arg) == 1 then
      vim.cmd.Oil(first_arg)
    end
  end,
})

-- Auto resize splits when the terminal's window is resized
autocmd("VimResized", {
  command = "wincmd =",
})

-- Terraform
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
