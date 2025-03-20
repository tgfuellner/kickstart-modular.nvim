return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    config = function()
      local ibl = require 'ibl'
      local highlight = {
        'iblColor1',
        'iblColor2',
      }

      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'iblColor1', { fg = '#424242' })
        vim.api.nvim_set_hl(0, 'iblColor2', { fg = '#6F749F' })
      end)

      ibl.setup {
        indent = { highlight = highlight },
      }
    end,
  },
}
