return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>ff",
      function()
        local current_buffer_dir = vim.fn.expand("%:p:h")
        local git_root = vim.fn.systemlist("cd " .. vim.fn.shellescape(current_buffer_dir) .. " && git rev-parse --show-toplevel 2>/dev/null")[1]

        if git_root and git_root ~= "" then
          require("telescope.builtin").find_files({ cwd = git_root })
        else
          require("telescope.builtin").find_files({ cwd = current_buffer_dir })
        end
      end,
      desc = "Find files (git root or buffer dir)",
    },
    {
      "<leader>fg",
      function()
        -- Get the directory of the current buffer
        local current_buffer_dir = vim.fn.expand("%:p:h")

        -- Try to find git root from the current buffer's directory
        local git_root = vim.fn.systemlist("cd " .. vim.fn.shellescape(current_buffer_dir) .. " && git rev-parse --show-toplevel 2>/dev/null")[1]

        if git_root and git_root ~= "" then
          require("telescope.builtin").live_grep({ cwd = git_root })
        else
          -- Fall back to the current buffer's directory
          require("telescope.builtin").live_grep({ cwd = current_buffer_dir })
        end
      end,
      desc = "Live grep (git root or buffer dir)",
    },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        -- File and directory patterns to ignore
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          "dist/",
          "build/",
          "target/",
          "vendor/",
          ".cache/",
          ".claude/",
          ".local/",
          ".npm/",
          ".cargo/",
          "%.lock",
          "package%-lock.json",
          "yarn.lock",
          "lazy%-lock.json",
        },
        -- Respect .gitignore files
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Search hidden files
          "--glob=!.git/", -- But exclude .git directory
          "--glob=!.claude/",
          "--glob=!.local/",
          "--glob=!node_modules/",
        },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          },
        },
        -- Performance improvements
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = true, -- Show hidden files
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
        },
      },
    })
  end,
}
