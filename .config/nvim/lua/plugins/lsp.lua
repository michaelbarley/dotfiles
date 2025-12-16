return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Setup mason first
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup mason-lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls", -- TypeScript/JavaScript
        "eslint", -- ESLint
        "html",
        "cssls",
        "jsonls",
        "lua_ls",
        "intelephense", -- PHP
      },
      automatic_installation = true,
    })

    -- Setup completion capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- LSP keymaps (triggered when LSP attaches to buffer)
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end

    -- Configure language servers using the new vim.lsp.config API
    -- TypeScript/JavaScript
    vim.lsp.config.ts_ls = {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }

    -- ESLint
    vim.lsp.config.eslint = {
      cmd = { "vscode-eslint-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "package.json" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- HTML
    vim.lsp.config.html = {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- CSS
    vim.lsp.config.cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- JSON
    vim.lsp.config.jsonls = {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Lua
    vim.lsp.config.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- PHP
    vim.lsp.config.intelephense = {
      cmd = { "intelephense", "--stdio" },
      filetypes = { "php" },
      root_markers = { "composer.json", ".git" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          files = {
            maxSize = 1000000,
          },
        },
      },
    }

    -- Enable LSP servers for their respective filetypes
    vim.lsp.enable({ "ts_ls", "eslint", "html", "cssls", "jsonls", "lua_ls", "intelephense" })

    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
