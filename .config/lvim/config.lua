-- Jao Configs

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.relativenumber = true

lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

lvim.plugins = {
    "folke/tokyonight.nvim",
    "catppuccin/nvim",
    "EdenEast/nightfox.nvim",
    "rose-pine/neovim",

    "chipsenkbeil/vimwiki-server.nvim",

    "norcalli/nvim-colorizer.lua",
    "ChristianChiarulli/swenv.nvim",
    "stevearc/dressing.nvim",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/neotest",
    "nvim-neotest/neotest-python",
}

lvim.colorscheme = "catppuccin-macchiato"

lvim.keys.normal_mode["<S-x>"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprev<CR>"
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"

lvim.builtin.treesitter.ensure_installed = {
    "python",
    "ruby",
    "javascript",
    "typescript",
    "java",
    "cpp",
    "c",
    "rust",
    "go",
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, { name = "rubocop" } , { name = "gofumpt" }}
lvim.format_on_save.enabled = false

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } }, { command = "rubocop", filetypes = { "ruby" } } }


-- Python DAP
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
  "Test Class" }
lvim.builtin.which_key.mappings["dF"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>",
  "Test Summary" }


lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
-- Python DAP

-- Colorizer
-- Attaches to every FileType mode
require 'colorizer'.setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  'css';
  'javascript';
  html = {
    mode = 'foreground';
  }
}

require 'colorizer'.setup({
  'css';
  'javascript';
  html = { mode = 'background' };
}, { mode = 'foreground' })

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  '!vim'; -- Exclude vim from highlighting.
}
