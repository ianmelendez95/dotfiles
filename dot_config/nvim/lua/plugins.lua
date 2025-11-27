return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      require('onedark').load()
    end
  },
  { "nvim-lua/plenary.nvim" },
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
     dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' 
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate'
  },
  { "neovim/nvim-lspconfig" },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  }
}

  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show({ global = false })
  --       end,
  --       desc = "Buffer Local Keymaps (which-key)",
  --     },
  --   },
  -- }
  --
  -- {
  --   "EdenEast/nightfox.nvim",
  --   priority = 1000,
  --   config = function() 
  --     vim.cmd("colorscheme carbonfox")
  --   end
  -- },
