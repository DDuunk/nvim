return {
  "laytan/cloak.nvim",
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      cloak_length = nil, -- Use a number to hide the true length of the value
      try_all_patterns = true,
      cloak_telescope = true, -- Cloak Telescope preview buffers
      patterns = {
        {
          file_pattern = ".env*", -- Matches any file starting with ".env"
          cloak_pattern = "=.+", -- Matches an equals sign followed by any characters
          replace = nil, -- Retains the first character by default
        },
        {
          file_pattern = ".npmrc",
          cloak_pattern = "=.+", -- Matches an equals sign followed by any characters
          replace = nil, -- Retains the first character by default
        },
      },
    })
  end,
}
