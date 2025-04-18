return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'markdown', 'markdown_inline' },
        highlight = { enable = true },
      }
    end,
  },
  config = function()
    local obsidian = require 'obsidian'
    obsidian.setup {
      workspaces = {
        {
          name = 'vimwiki',
          path = '~/vimwiki',
          -- name = 'workwiki',
          -- path = '~/workwiki',
        },
      },
      daily_notes = {
        folder = 'diary',
      },
      preferred_link_style = 'markdown',
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        -- return tostring(os.time()) .. '-' .. suffix
        return suffix
      end,
      ui = {
        enable = false,
      },
    }
    -- vim.opt.conceallevel = 1
  end,
  cmd = {
    'ObsidianNew',
    'ObsidianToday',
    'ObsidianYesterday',
    'ObsidianDailies',
    'ObsidianSearch',
  },
}
