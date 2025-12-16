# Dotfiles

My personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- **bash** - Shell configuration (`.bashrc`)
- **tmux** - Terminal multiplexer configuration (`.tmux.conf`)
- **i3** - i3 window manager configuration (`.config/i3/`)
- **i3blocks** - i3blocks status bar configuration (`.config/i3blocks/`)
- **neovim** - Neovim editor configuration (`.config/nvim/`)

## What is GNU Stow?

GNU Stow is a symlink farm manager. It creates symbolic links from your dotfiles repository to your home directory, making it easy to:

- **Version control** your configuration files in a single repository
- **Deploy** configurations to any machine with a single command
- **Keep configs organized** in logical packages
- **Easily add/remove** configurations without manually managing symlinks

### How Stow Works

Stow takes files from a source directory (your dotfiles repo) and creates symlinks in a target directory (your home directory). The directory structure in your dotfiles repo mirrors where files should end up relative to your home directory.

```
~/dotfiles/                     →  ~/ (home directory)
├── .bashrc                     →  ~/.bashrc
├── .tmux.conf                  →  ~/.tmux.conf
└── .config/
    ├── nvim/                   →  ~/.config/nvim/
    │   ├── init.lua
    │   └── lua/
    └── i3/                     →  ~/.config/i3/
        └── config
```

## Installation

### 1. Install GNU Stow

**macOS (Homebrew):**
```bash
brew install stow
```

**Ubuntu/Debian:**
```bash
sudo apt install stow
```

**Fedora:**
```bash
sudo dnf install stow
```

**Arch Linux:**
```bash
sudo pacman -S stow
```

### 2. Clone this Repository

```bash
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Deploy Configurations with Stow

#### Deploy Everything at Once

From the dotfiles directory, run stow with `.` to symlink all configurations:

```bash
cd ~/dotfiles
stow .
```

This creates symlinks for all dotfiles in your home directory.

#### Deploy Selectively (Alternative Approach)

If you prefer to organize dotfiles into separate packages (subdirectories), you can deploy them individually:

```bash
stow bash      # Only bash config
stow nvim      # Only neovim config
stow tmux      # Only tmux config
```

### 4. Handling Existing Files

If you have existing configuration files, stow will refuse to overwrite them. You have two options:

**Option A: Backup and remove existing files first**
```bash
# Example for neovim
mv ~/.config/nvim ~/.config/nvim.backup
stow .
```

**Option B: Use --adopt to pull existing files into your dotfiles**
```bash
stow --adopt .
git diff  # Review changes
git checkout .  # Revert if you want to keep your dotfiles version
```

The `--adopt` flag moves existing files into your dotfiles repo and creates symlinks. Use `git diff` afterward to see what changed.

## Removing Configurations

To remove symlinks created by stow (unstow):

```bash
cd ~/dotfiles
stow -D .
```

This removes the symlinks but keeps your dotfiles repository intact.

## Updating Configurations

Since your configs are symlinked, any changes you make to `~/.config/nvim/` (for example) are automatically reflected in your dotfiles repo. Just commit and push:

```bash
cd ~/dotfiles
git add -A
git commit -m "Update configuration"
git push
```

## Configuration Details

### Neovim

A modern Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

**Plugins included:**
- **telescope.nvim** - Fuzzy finder (`<leader>ff` for files, `<leader>fg` for grep)
- **oil.nvim** - File explorer (`-` to open)
- **nvim-lspconfig** - LSP support (TypeScript, JavaScript, HTML, CSS, JSON, Lua, PHP)
- **nvim-cmp** - Autocompletion with snippets
- **conform.nvim** - Format on save (prettier, stylua, pint)
- **treesitter** - Syntax highlighting
- **gitsigns.nvim** - Git integration with inline blame
- **gruvbox** - Color scheme
- **lualine** - Status line
- **bufferline** - Buffer tabs
- **which-key** - Keybinding hints
- **vim-tmux-navigator** - Seamless tmux/vim navigation

**Dependencies:**
- Neovim >= 0.9.0
- Git
- A Nerd Font
- ripgrep
- Node.js
- prettier (`npm install -g prettier`)
- stylua (`brew install stylua`)

### tmux

- Mouse support enabled
- 10,000 line scrollback buffer
- Vim-tmux-navigator integration (`Ctrl+h/j/k/l` to navigate panes)

### bash

Standard bash configuration with:
- History settings
- Color support
- Common aliases (`ll`, `la`, `l`)
- PATH additions for local binaries and Neovim

### i3 / i3blocks

i3 window manager and status bar configuration (Linux).

## Tips

### Dry Run

Preview what stow will do without making changes:

```bash
stow -n -v .
```

The `-n` flag enables dry-run mode, `-v` enables verbose output.

### Ignore Files

Stow automatically ignores common files like `.git`, `README.md`, and `LICENSE`. You can customize this by creating a `.stow-local-ignore` file.

### Multiple Machines

For machine-specific configurations, you can:

1. Use git branches for different machines
2. Create machine-specific directories and selectively stow them
3. Use conditional logic in your shell configs based on hostname

## Troubleshooting

**"CONFLICT: ... => ..."**

A file already exists at the target location. Either remove/backup the existing file or use `--adopt`.

**"stow: ERROR: ..."**

Make sure you're running stow from within the dotfiles directory, or specify the directory with `-d`:

```bash
stow -d ~/dotfiles -t ~ .
```

**Symlinks not appearing**

Ensure the directory structure in your dotfiles matches where files should go relative to `~`. For `.config/nvim/`, the path in dotfiles should be `dotfiles/.config/nvim/`.
