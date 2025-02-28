return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
      -- vim.cmd.colorscheme "habamax"
      -- vim.cmd.colorscheme "wildcharm"
      -- vim.cmd.colorscheme "lunaperche"
      -- vim.cmd.colorscheme "peachpuff"
      -- vim.cmd.colorscheme "slate"
    end
  }
}
