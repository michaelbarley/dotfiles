return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup{
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both"
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon', -- can be 'icon' | 'underline' | 'none'
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true
          }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- can be "slant" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        sort_by = 'insert_after_current',
      },
      highlights = {
        modified = {
          fg = '#e0af68', -- yellow/orange color for modified indicator
        },
        modified_visible = {
          fg = '#e0af68',
        },
        modified_selected = {
          fg = '#e0af68',
        },
      }
    }

    -- Keymaps for easier buffer navigation
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Next buffer' })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Previous buffer' })
    vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { silent = true, desc = 'Pick buffer' })
    vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { silent = true, desc = 'Pick buffer to close' })
    vim.keymap.set('n', '<leader>bh', ':BufferLineCloseLeft<CR>', { silent = true, desc = 'Close buffers to the left' })
    vim.keymap.set('n', '<leader>bl', ':BufferLineCloseRight<CR>', { silent = true, desc = 'Close buffers to the right' })
  end,
}
