return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- Use the latest version
  lazy = false, -- nvim-tree is generally not lazy-loaded
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, but recommended for icons
  },
  opts = {
    -- add your options here
    filters = {
      dotfiles = true, -- Show dotfiles
    },
    view = {
      width = 30,
    },
    -- map your keymaps here
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file in explorer" },
    },
    -- You can add more configurations here, see the documentation for details
  },
  -- config is called after the plugin is loaded and setup() is executed by lazy.nvim
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
