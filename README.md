# Dotfiles

My personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Repository Structure

```
~/dotfiles/
├── .bashrc                      # Bash shell configuration
├── .tmux.conf                   # tmux terminal multiplexer
├── .config/
│   ├── i3/
│   │   └── config               # i3 window manager (Linux)
│   ├── i3blocks/
│   │   └── config               # i3blocks status bar (Linux)
│   └── nvim/
│       ├── init.lua             # Neovim entry point
│       ├── lua/
│       │   ├── config/
│       │   │   └── options.lua  # Editor settings
│       │   └── plugins/         # Plugin configurations
│       │       ├── bufferline.lua
│       │       ├── cmp.lua
│       │       ├── conform.lua
│       │       ├── gitsigns.lua
│       │       ├── indent-blankline.lua
│       │       ├── lsp.lua
│       │       ├── lualine.lua
│       │       ├── mason.lua
│       │       ├── oil.lua
│       │       ├── telescope.lua
│       │       ├── theme.lua
│       │       ├── tmux-navigator.lua
│       │       ├── treesitter.lua
│       │       └── which-key.lua
│       └── README.md
└── README.md
```

## Quick Start

### New Machine Setup

```bash
# 1. Install stow
# macOS:
brew install stow

# Ubuntu/Debian:
sudo apt install stow

# Fedora:
sudo dnf install stow

# Arch:
sudo pacman -S stow

# 2. Clone the repository
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles

# 3. Backup existing configs (if any)
mv ~/.bashrc ~/.bashrc.backup 2>/dev/null
mv ~/.tmux.conf ~/.tmux.conf.backup 2>/dev/null
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
mv ~/.config/i3 ~/.config/i3.backup 2>/dev/null
mv ~/.config/i3blocks ~/.config/i3blocks.backup 2>/dev/null

# 4. Deploy all configurations
cd ~/dotfiles
stow .

# 5. Verify symlinks were created
ls -la ~/.bashrc ~/.tmux.conf ~/.config/nvim ~/.config/i3 2>/dev/null
```

### Migrating an Existing Machine

If you already have these configurations installed (not via stow), follow these steps to switch to the stow-managed approach. This is useful when you want all your machines to use the same dotfiles repo.

**Before you begin:** Your existing configs will be deleted and replaced with symlinks to the dotfiles repo. The dotfiles repo should already contain the configurations you want (if not, copy them in first).

```bash
# 1. Install stow (if not already installed)
# macOS:
brew install stow

# Ubuntu/Debian:
sudo apt install stow

# 2. Clone the dotfiles repo (if not already cloned)
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles

# 3. Check what configs you currently have
ls -la ~/.bashrc ~/.tmux.conf 2>/dev/null
ls -la ~/.config/nvim ~/.config/i3 ~/.config/i3blocks 2>/dev/null

# 4. Preview what stow will do (dry run)
cd ~/dotfiles
stow -n -v .
# This will show conflicts for any existing files

# 5. Remove existing configurations
# WARNING: This deletes your current configs! Make sure they're
# already in the dotfiles repo or backed up elsewhere first.

# Remove shell configs
rm -f ~/.bashrc
rm -f ~/.tmux.conf

# Remove neovim (note: if it has its own .git, you lose that history)
rm -rf ~/.config/nvim

# Remove i3 configs (Linux only)
rm -rf ~/.config/i3
rm -rf ~/.config/i3blocks

# 6. Deploy symlinks
cd ~/dotfiles
stow .

# 7. Verify symlinks were created (should show -> arrows)
ls -la ~/.bashrc ~/.tmux.conf
ls -la ~/.config/ | grep -E "nvim|i3"

# 8. Test the configurations
source ~/.bashrc              # Reload shell config
nvim                          # Should work with all plugins
tmux                          # Should work with your config
```

**Note about Neovim:** If your `~/.config/nvim` was its own git repository, that git history will be lost when you delete it. The configuration files are preserved in the dotfiles repo, but as part of this repo's history instead.

**After migration:** Any edits you make to `~/.config/nvim`, `~/.bashrc`, etc. are actually editing the files in `~/dotfiles/` (via symlinks). Just `cd ~/dotfiles && git add -A && git commit && git push` to sync changes.

---

## What is GNU Stow?

GNU Stow is a symlink farm manager that creates symbolic links from your dotfiles repository to your home directory.

### How It Works

When you run `stow .` from `~/dotfiles`, stow creates symlinks in your home directory that mirror the repository structure:

| Repository Path | Symlink Created |
|-----------------|-----------------|
| `~/dotfiles/.bashrc` | `~/.bashrc` → `~/dotfiles/.bashrc` |
| `~/dotfiles/.tmux.conf` | `~/.tmux.conf` → `~/dotfiles/.tmux.conf` |
| `~/dotfiles/.config/nvim/` | `~/.config/nvim` → `~/dotfiles/.config/nvim` |
| `~/dotfiles/.config/i3/` | `~/.config/i3` → `~/dotfiles/.config/i3` |

### Benefits

- **Version control** - All configs in one git repository
- **Portable** - Deploy to any machine with one command
- **Synchronized** - Edit files anywhere, changes reflect in repo
- **Reversible** - Remove symlinks without deleting configs

---

## Installation

### Prerequisites

#### All Platforms
- Git
- GNU Stow

#### For Neovim
- Neovim >= 0.9.0
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope grep)
- Node.js (for LSP servers)
- `npm install -g prettier` (for formatting)
- `brew install stylua` or `cargo install stylua` (for Lua formatting)

#### For i3 (Linux only)
- i3 window manager
- i3blocks
- dmenu
- feh (wallpaper)
- brightnessctl (brightness control)
- PipeWire + wpctl (audio)
- NetworkManager + nm-applet
- blueman (Bluetooth)

### Step-by-Step Installation

#### 1. Install GNU Stow

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

#### 2. Clone the Repository

```bash
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

#### 3. Handle Existing Configuration Files

Stow will refuse to overwrite existing files. Choose one approach:

**Option A: Backup and Remove (Recommended)**
```bash
# Create backup directory
mkdir -p ~/dotfiles-backup

# Backup existing configs
mv ~/.bashrc ~/dotfiles-backup/ 2>/dev/null
mv ~/.tmux.conf ~/dotfiles-backup/ 2>/dev/null
mv ~/.config/nvim ~/dotfiles-backup/ 2>/dev/null
mv ~/.config/i3 ~/dotfiles-backup/ 2>/dev/null
mv ~/.config/i3blocks ~/dotfiles-backup/ 2>/dev/null
```

**Option B: Adopt Existing Files**

This pulls your existing files INTO the dotfiles repo, then creates symlinks:
```bash
cd ~/dotfiles
stow --adopt .

# Review what changed
git diff

# Keep dotfiles version (discard adopted changes):
git checkout .

# OR keep your existing version (commit adopted changes):
git add -A && git commit -m "Adopt existing configs"
```

#### 4. Deploy with Stow

```bash
cd ~/dotfiles
stow .
```

#### 5. Verify Installation

```bash
# Check symlinks exist
ls -la ~ | grep -E "bashrc|tmux"
ls -la ~/.config | grep -E "nvim|i3"

# Test each config
source ~/.bashrc          # Reload bash
tmux                      # Start tmux (exit with: exit)
nvim                      # Start neovim (plugins auto-install on first launch)
```

---

## Managing Configurations

### Removing Symlinks (Unstow)

Remove all symlinks without deleting the repository:
```bash
cd ~/dotfiles
stow -D .
```

### Updating Configurations

Since configs are symlinked, edits anywhere are reflected in the repo:
```bash
# Edit via the symlink
nvim ~/.config/nvim/init.lua

# Or edit directly in repo
nvim ~/dotfiles/.config/nvim/init.lua

# Both edit the same file! Commit changes:
cd ~/dotfiles
git add -A
git commit -m "Update neovim config"
git push
```

### Adding New Configurations

```bash
cd ~/dotfiles

# Example: Add zsh config
mv ~/.zshrc ~/dotfiles/.zshrc
stow .  # Recreate symlinks
git add .zshrc
git commit -m "Add zsh configuration"
```

### Pulling Updates on Another Machine

```bash
cd ~/dotfiles
git pull
# Symlinks already point to the files, so updates are automatic!
```

### Dry Run (Preview Changes)

See what stow would do without making changes:
```bash
cd ~/dotfiles
stow -n -v .
```

---

## Configuration Details

### Neovim

A modern Neovim setup using [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

**Key Settings:**
- Leader key: `Space`
- Relative line numbers
- 4-space indentation (spaces, not tabs)
- Format on save

**Plugins:**

| Plugin | Purpose | Key Bindings |
|--------|---------|--------------|
| telescope.nvim | Fuzzy finder | `<leader>ff` files, `<leader>fg` grep, `<leader>fb` buffers |
| oil.nvim | File explorer | `-` open parent directory |
| nvim-lspconfig | Language servers | `gd` go to definition, `K` hover, `<leader>ca` code action |
| nvim-cmp | Autocompletion | `Tab`/`S-Tab` navigate, `Enter` confirm |
| conform.nvim | Formatting | `<leader>fm` format, auto-format on save |
| gitsigns.nvim | Git integration | `<leader>gs` stage hunk, `<leader>gb` blame line |
| treesitter | Syntax highlighting | Automatic |
| gruvbox | Color scheme | Dark mode |
| lualine | Status line | Shows mode, branch, diagnostics |
| bufferline | Buffer tabs | `Tab`/`S-Tab` cycle buffers |
| which-key | Keybinding hints | Press `<leader>` and wait |
| vim-tmux-navigator | Tmux integration | `Ctrl+h/j/k/l` navigate panes |

**LSP Support:**
- TypeScript/JavaScript (ts_ls)
- ESLint
- HTML, CSS, JSON
- Lua
- PHP (intelephense)

**First Launch:**
Plugins install automatically. LSP servers install via Mason when you open relevant file types.

### tmux

**Features:**
- Mouse support (scrolling, selecting panes, resizing)
- 10,000 line scrollback history
- Seamless vim/tmux navigation with `Ctrl+h/j/k/l`

**Navigation:**
| Key | Action |
|-----|--------|
| `Ctrl+h` | Move to left pane (works in vim too) |
| `Ctrl+j` | Move to pane below |
| `Ctrl+k` | Move to pane above |
| `Ctrl+l` | Move to right pane |

### Bash

**Features:**
- History: 1000 commands in memory, 2000 in file
- No duplicate history entries
- Color support for ls, grep
- Aliases: `ll` (detailed list), `la` (show hidden), `l` (compact)

**PATH Additions:**
- `~/.local/bin`
- `/opt/nvim/bin`

### i3 Window Manager (Linux)

**Mod Key:** `Super` (Windows key)

**Theme:** Gruvbox dark with yellow accent for focused windows

**Key Bindings:**

| Key | Action |
|-----|--------|
| `Mod+Return` | Open terminal |
| `Mod+d` | Open dmenu (app launcher) |
| `Mod+Shift+q` | Close focused window |
| `Mod+h` | Split horizontal |
| `Mod+v` | Split vertical |
| `Mod+f` | Toggle fullscreen |
| `Mod+1-0` | Switch to workspace 1-10 |
| `Mod+Shift+1-0` | Move window to workspace |
| `Mod+j/k/l/;` | Focus left/down/up/right |
| `Mod+Shift+j/k/l/;` | Move window left/down/up/right |
| `Mod+s` | Stacking layout |
| `Mod+w` | Tabbed layout |
| `Mod+e` | Toggle split layout |
| `Mod+Shift+space` | Toggle floating |
| `Mod+r` | Enter resize mode |
| `Mod+Shift+c` | Reload config |
| `Mod+Shift+r` | Restart i3 |
| `Mod+Shift+e` | Exit i3 |

**Media Keys:**
- Volume up/down/mute (via wpctl/PipeWire)
- Brightness up/down (via brightnessctl)

**Startup Applications:**
- dex (XDG autostart)
- xss-lock + i3lock (screen lock)
- nm-applet (network)
- blueman-applet (Bluetooth)
- feh (wallpaper)

**HiDPI:** Configured for 192 DPI scaling

### i3blocks Status Bar (Linux)

Minimal status bar showing:
- Volume (with mute indicator)
- Battery percentage
- Date and time

Colors match Gruvbox theme.

---

## Platform-Specific Notes

### macOS

The following configs work on macOS:
- Neovim
- tmux
- Bash

The following are Linux-only:
- i3 / i3blocks (X11 window manager)

On macOS, stow will create symlinks for i3 configs, but they won't be used unless you're running X11.

### Linux

All configurations are applicable. Ensure i3 dependencies are installed:

**Ubuntu/Debian:**
```bash
sudo apt install i3 i3blocks dmenu feh brightnessctl network-manager blueman pipewire wireplumber
```

**Arch:**
```bash
sudo pacman -S i3-wm i3blocks dmenu feh brightnessctl networkmanager blueman pipewire wireplumber
```

---

## Troubleshooting

### "CONFLICT: ... already exists"

A file exists at the target location. Either:
1. Remove/backup the existing file, or
2. Use `stow --adopt .` to pull it into the repo

### "stow: ERROR: ... does not exist"

Ensure you're running stow from the dotfiles directory:
```bash
cd ~/dotfiles
stow .
```

Or specify paths explicitly:
```bash
stow -d ~/dotfiles -t ~ .
```

### Symlinks Not Created

1. Check you're in the right directory: `pwd` should show `~/dotfiles`
2. Run with verbose output: `stow -v .`
3. Check for conflicts: `stow -n -v .`

### Neovim Plugins Not Installing

1. Ensure you have git and a working internet connection
2. Delete lazy.nvim data and restart:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   nvim
   ```

### LSP Servers Not Working

1. Open Neovim and run `:Mason`
2. Ensure the required servers are installed
3. Check `:LspInfo` for status

### i3 Not Starting

1. Check X11 is installed and running
2. Verify i3 config syntax: `i3 -C`
3. Check logs: `~/.local/share/xorg/Xorg.0.log`

---

## Stow Reference

| Command | Description |
|---------|-------------|
| `stow .` | Create symlinks for all configs |
| `stow -D .` | Remove symlinks (unstow) |
| `stow -R .` | Restow (remove then recreate) |
| `stow --adopt .` | Adopt existing files into repo |
| `stow -n -v .` | Dry run with verbose output |
| `stow -d DIR -t TARGET .` | Specify source and target dirs |

---

## Adding to This Repository

To add a new configuration:

```bash
# 1. Move the config into the dotfiles repo
#    (preserve the path relative to home)
mv ~/.config/newapp ~/dotfiles/.config/newapp

# 2. Restow to create the symlink
cd ~/dotfiles
stow -R .

# 3. Commit
git add .config/newapp
git commit -m "Add newapp configuration"
git push
```
