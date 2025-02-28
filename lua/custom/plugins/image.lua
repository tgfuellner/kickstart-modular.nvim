return {
    "3rd/image.nvim",
    -- build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown" },
            highlight = { enable = true },
          })
        end,
      },
    },
    opts = {},
    config = function()
      require("image").setup({
      backend = "kitty",
      -- processor = "magick_rock", -- or "magick_cli"
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          floating_windows = false, -- if true, images will be rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          resolve_image_path = function(document_path, image_path, fallback)
            -- Define the absolute path to your Assets directory
            local assets_dir = vim.fn.expand("~/vimwiki/Attachements") -- not the path to vault, but to the assets dir

            image_path = string.gsub(image_path, "|.*", "")    -- schneidet Grössenangaben ab
            -- Check if the image_path is already an absolute path
            if image_path:match("^/") then
                -- If it's an absolute path, leave it unchanged
                return image_path
            end

            -- Construct the new image path by prepending the Assets directory
            local new_image_path = assets_dir .. "/" .. image_path

            -- Check if the constructed path exists
            if vim.fn.filereadable(new_image_path) == 1 then
                return new_image_path
            else
                -- If the file doesn't exist in Assets, fallback to default behavior
                return fallback(document_path, image_path)
            end
          end,
        },
        neorg = {
          enabled = false,
          filetypes = { "norg" },
        },
        typst = {
          enabled = false,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    })
    end
}
