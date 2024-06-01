-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("DylanDuunk", {}),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("QuitPre", {
  group = vim.api.nvim_create_augroup("CloseLoclistWindowGroup", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.buftype == '' then
      vim.cmd('lclose')
    end
  end
})

-- vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
--
-- vim.api.nvim_create_autocmd("User", {
--   group = "lualine_augroup",
--   pattern = "LspProgressStatusUpdated",
--   callback = require("lualine").refresh,
-- })

vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})
