-- nalmead the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.width = 50;
vim.opt.relativenumber = true

-- Cmd + 1 to switch to buffer 1
vim.api.nvim_set_keymap('n', '<D-1>', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })

-- Cmd + 2 to switch to buffer 2
vim.api.nvim_set_keymap('n', '<D-2>', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })

-- Cmd + 3 to switch to buffer 3
vim.api.nvim_set_keymap('n', '<D-3>', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })

-- Cmd + 4 to switch to buffer 4
vim.api.nvim_set_keymap('n', '<D-4>', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })


lvim.plugins = {
  {
    "sainnhe/gruvbox-material",
    'chrisgrieser/nvim-puppeteer', -- for auto string interpolation converter
    'tpope/vim-surround',          -- surround selected text with parenthesis, curly braces etc
    {
      "windwp/nvim-ts-autotag",
      event = "BufRead",
      config = function()
        require("nvim-ts-autotag").setup({
          filetypes = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte" },
        })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gvdiffsplit",
      "Gdiffget",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
}
vim.g.gruvbox_material_background = 'medium'   -- or 'soft', 'hard'
vim.g.gruvbox_material_foreground = 'material' -- or 'mix', 'original'
vim.g.gruvbox_material_better_performance = 1

-- Eslint
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact" } }
}

-- Set up formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd", filetypes = { "javascript", "typescript", "html", "css", "json" } },
}

lvim.format_on_save.enabled = true

-- floating terminal window on leader + j
-- lvim.keys.normal_mode["<leader>j"] = ":ToggleTerm direction=float<CR><cmd>startinsert<cr>"

-- Define the new terminal mapping
local my_search_mapping = {
  T = { "<cmd>Telescope<cr>", "telescope" }
}

-- Retrieve the existing leader s mappings
local existing_search_mappings = lvim.builtin.which_key.mappings["s"] or {}

-- Merge the existing mappings with the new mapping
for key, value in pairs(my_search_mapping) do
  existing_search_mappings[key] = value
end

-- Set the updated mappings
lvim.builtin.which_key.mappings["s"] = existing_search_mappings


-- Define the new terminal mapping
local my_git_mappings = {
  m = { "<cmd>Gvdiffsplit!<cr>", "Merge conflict diff fix" }
}

-- Retrieve the existing leader g mappings
local existing_git_mappings = lvim.builtin.which_key.mappings["g"] or {}

-- Merge the existing mappings with the new mapping
for key, value in pairs(my_git_mappings) do
  existing_git_mappings[key] = value
end

-- Set the updated mappings
lvim.builtin.which_key.mappings["g"] = existing_git_mappings
