return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon Add File",
    },
    {
      "<C-e>",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Harpoon Menu",
    },
    {
      "<C-j>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon File 1",
    },
    {
      "<C-k>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon File 2",
    },
  },
}
