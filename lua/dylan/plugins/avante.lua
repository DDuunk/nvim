return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Always pull the latest changes
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- Optional, or use 'echasnovski/mini.icons'
      "zbirenbaum/copilot.lua", -- For provider = 'copilot'
    },
    build = "make", -- Change this if using Windows
    opts = {
      provider = "ollama",
      vendors = {
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://127.0.0.1:11434/v1",
          model = "deepseek-r1:1.5b",
        },
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim", -- Support for image pasting
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = { insert_mode = true },
        use_absolute_path = true, -- Required for Windows users
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim", -- Markdown rendering support
    ft = { "markdown", "Avante" }, -- Lazy loading based on filetype
    opts = { file_types = { "markdown", "Avante" } },
  },
}
