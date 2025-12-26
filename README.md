# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **Neovim** - Modern config with lazy.nvim, LSP, Telescope, Gruvbox theme
- **tmux** - Mouse support, vim-style navigation
- **Bash** - Aliases, history settings, PATH config
- **Zsh** - Aliases, history, completion, Catppuccin Mocha prompt
- **i3 / i3blocks** - Tiling window manager (Linux only)
- **VLC** - Maximum quality settings with VA-API hardware acceleration

## How It Works

GNU Stow creates symlinks from this repo to your home directory:

```
~/dotfiles/.config/nvim  →  ~/.config/nvim
~/dotfiles/.bashrc       →  ~/.bashrc
~/dotfiles/.zshrc        →  ~/.zshrc
~/dotfiles/.tmux.conf    →  ~/.tmux.conf
```

Edit files anywhere - they're the same file. Commit and push to sync across machines.

---

## Fresh Machine Setup

For a new laptop with no existing configs.

```bash
# 1. Install stow
brew install stow          # macOS
sudo apt install stow      # Ubuntu/Debian
sudo pacman -S stow        # Arch

# 2. Clone the repo
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles

# 3. Deploy symlinks
cd ~/dotfiles
stow .

# 4. Verify (should show -> arrows)
ls -la ~/.bashrc ~/.tmux.conf
ls -la ~/.config/nvim
```

Done. Open `nvim` and plugins will auto-install on first launch.

---

## Existing Machine Setup

For a laptop that already has these configs installed (like migrating to stow).

```bash
# 1. Install stow
brew install stow          # macOS
sudo apt install stow      # Ubuntu/Debian
sudo pacman -S stow        # Arch

# 2. Clone the repo (skip if already cloned)
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles

# 3. Check what you currently have
ls -la ~/.bashrc ~/.tmux.conf 2>/dev/null
ls -la ~/.config/nvim 2>/dev/null

# 4. Preview what stow will do (dry run)
cd ~/dotfiles
stow -n -v .
# Shows conflicts for existing files - this is expected

# 5. Remove existing configs
# WARNING: Make sure they're already in the dotfiles repo first!
rm -f ~/.bashrc
rm -f ~/.zshrc
rm -f ~/.tmux.conf
rm -rf ~/.config/nvim
rm -rf ~/.config/i3        # Linux only
rm -rf ~/.config/i3blocks  # Linux only

# 6. Deploy symlinks
cd ~/dotfiles
stow .

# 7. Verify (should show -> arrows)
ls -la ~/.bashrc ~/.tmux.conf
ls -la ~/.config/nvim
```

---

## Daily Usage

### Syncing Changes

Any edits to your configs are automatically in the dotfiles repo (they're symlinks):

```bash
cd ~/dotfiles
git add -A
git commit -m "Update config"
git push
```

### Pulling Updates

On another machine:

```bash
cd ~/dotfiles
git pull
# Changes apply immediately - symlinks point to the updated files
```

### Adding New Configs

```bash
# Move config into dotfiles (preserve path structure)
mv ~/.config/newapp ~/dotfiles/.config/newapp

# Recreate symlinks
cd ~/dotfiles
stow -R .

# Commit
git add .config/newapp
git commit -m "Add newapp config"
git push
```

### Removing Symlinks

```bash
cd ~/dotfiles
stow -D .
```

---

## Neovim Details

**Leader key:** `Space`

| Keybinding | Action |
|------------|--------|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `-` | Open file explorer (Oil) |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>fm` | Format file |
| `Tab` / `S-Tab` | Cycle buffers |
| `Ctrl+h/j/k/l` | Navigate splits (works with tmux too) |

**LSP support:** TypeScript, JavaScript, HTML, CSS, JSON, Lua, PHP

**Dependencies:**
```bash
# macOS
brew install neovim ripgrep node
npm install -g prettier
brew install stylua
```

---

## tmux Details

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate panes (seamless with vim) |
| Mouse scroll | Scroll history |
| Mouse click | Select pane |

---

## Troubleshooting

**"cannot stow ... existing target"**

File already exists. Remove it first, then run `stow .`

**Neovim plugins not loading**

```bash
rm -rf ~/.local/share/nvim/lazy
nvim  # Reinstalls plugins
```

**"shopt: command not found" when sourcing bashrc**

You're using zsh (macOS default), not bash. This is fine - `.bashrc` only applies when running bash.
