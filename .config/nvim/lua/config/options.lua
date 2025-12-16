-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line number settings
vim.opt.number = true         -- Show absolute line number on current line
vim.opt.relativenumber = true -- Show relative line numbers on all other lines

-- Tab and indentation settings
vim.opt.tabstop = 4           -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4       -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true      -- Convert tabs to spaces
