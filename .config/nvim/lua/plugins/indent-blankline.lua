return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local hooks = require("ibl.hooks")
    -- Create white/bright highlight for indent lines
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#585B70" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#CDD6F4" })
    end)

    require("ibl").setup({
      indent = {
        char = "▏",
        tab_char = "▏",
        highlight = "IblIndent",
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        show_exact_scope = true,
        injected_languages = true,
        highlight = "IblScope",
        priority = 1024,
        include = {
          node_type = {
            ["*"] = {
              "argument_list",
              "arguments",
              "assignment_statement",
              "block",
              "bracket",
              "call_expression",
              "class",
              "do_block",
              "element",
              "except",
              "for_statement",
              "function",
              "function_declaration",
              "function_definition",
              "if_statement",
              "import_statement",
              "list_literal",
              "method",
              "object",
              "operation",
              "parenthesized_expression",
              "selector",
              "statement_block",
              "switch_statement",
              "table",
              "table_constructor",
              "try_statement",
              "tuple",
              "while_statement",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "oil",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    })

    -- Rainbow delimiters integration for matching brackets
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
