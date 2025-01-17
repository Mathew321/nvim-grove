return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      "kkharji/sqlite.lua",
      -- "nvim-telescope/telescope-frecency.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      local function formattedName(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then
          return tail
        end
        return string.format("%s\t\t%s", tail, parent)
      end

      telescope.setup({
        file_ignore_patterns = { "%.git/." },
        -- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next,     -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },

          },
          previewer = true,
          file_ignore_patterns = { "node_modules", "package-lock.json" },
          initial_mode = "insert",
          select_strategy = "reset",
          sorting_strategy = "ascending",
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = true,
            previewer = true,
            path_display = formattedName,
            layout_config = {
              height = 0.6,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          git_files = {
            previewer = true,
            path_display = formattedName,
            layout_config = {
              height = 0.6,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          buffers = {
            path_display = formattedName,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
              },
            },
            previewer = true,
            initial_mode = "normal",
            -- theme = "dropdown",
            layout_config = {
              height = 0.6,
              width = 0.6,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          current_buffer_fuzzy_find = {
            previewer = true,
            layout_config = {
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
          },
          grep_string = {
            only_sort_text = true,
            previewer = true,
          },
          lsp_references = {
            show_line = false,
            previewer = true,
          },
          treesitter = {
            show_line = false,
            previewer = true,
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer = true,
              initial_mode = "normal",
              sorting_strategy = "ascending",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.6,
                  preview_width = 0.6,
                },
              },
            }),
          },
        },
      })
      telescope.load_extension("ui-select")
    end,
  },
    {
      'ThePrimeagen/harpoon',
      config = function()
         require("harpoon").setup()
         vim.keymap.set('n', 'll', require("harpoon.mark").add_file, {})
         vim.keymap.set('n', '<leader>tm', require("harpoon.ui").toggle_quick_menu, {})
         vim.keymap.set('n', 'xx', require("harpoon.ui").nav_next, {})
         vim.keymap.set('n', 'cc', require("harpoon.ui").nav_prev, {})
      end
    },
}
