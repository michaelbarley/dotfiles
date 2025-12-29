# Dotfiles

Personal configuration files for Ubuntu, managed with GNU Stow.

## What's Included

| Config | Description |
|--------|-------------|
| **Neovim** | Modern editor with lazy.nvim, LSP, Telescope, Gruvbox theme |
| **tmux** | Terminal multiplexer with mouse support, vim-style navigation |
| **Zsh** | Shell with aliases, completion, Catppuccin prompt |
| **Bash** | Shell config with aliases and PATH setup |
| **Rofi** | Application launcher with Gruvbox theme |

---

## Fresh Ubuntu Setup

Run these commands in order on a fresh Ubuntu install.

### 1. Install Dependencies

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install core tools
sudo apt install -y git stow zsh tmux curl wget unzip ripgrep fd-find

# Install build essentials (needed for some tools)
sudo apt install -y build-essential
```

### 2. Install Neovim (latest)

Ubuntu's apt version is outdated. Install the latest:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
```

### 3. Install Node.js (via nvm)

Required for LSP servers and formatters:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Restart terminal or run:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node
nvm install --lts
```

### 4. Install Nerd Font

Required for icons in Neovim and terminal:

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
fc-cache -fv
```

Then set your terminal emulator to use "JetBrainsMono Nerd Font".

### 5. Clone and Deploy Dotfiles

```bash
# Clone the repo
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles

# Remove existing configs that would conflict
rm -f ~/.bashrc ~/.zshrc ~/.tmux.conf
rm -rf ~/.config/nvim ~/.config/rofi

# Deploy symlinks
cd ~/dotfiles
stow .

# Verify (should show -> arrows pointing to dotfiles)
ls -la ~/.bashrc ~/.zshrc ~/.tmux.conf
```

### 6. Set Zsh as Default Shell

```bash
chsh -s $(which zsh)
```

Log out and back in for this to take effect.

### 7. Install Neovim Tools

Open Neovim - plugins will auto-install on first launch:

```bash
nvim
```

Then install formatters:

```bash
npm install -g prettier
```

For Lua formatting (optional):

```bash
# Download stylua
curl -LO https://github.com/JohnnyMorganz/StyLua/releases/latest/download/stylua-linux-x86_64.zip
unzip stylua-linux-x86_64.zip
chmod +x stylua
mv stylua ~/.local/bin/
rm stylua-linux-x86_64.zip
```

### 8. Install Rofi (Optional - Application Launcher)

```bash
sudo apt install -y rofi papirus-icon-theme
```

---

## Keybindings

### Neovim

**Leader key:** `Space`

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Find buffers |
| `-` | Open file explorer (Oil) |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>fm` | Format file |
| `Tab` / `S-Tab` | Cycle buffers |
| `Ctrl+h/j/k/l` | Navigate splits |

**LSP support:** TypeScript, JavaScript, HTML, CSS, JSON, Lua, PHP

### tmux

| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate panes (seamless with Neovim) |
| Mouse scroll | Scroll history |
| Mouse click | Select pane |

### Zsh Aliases

| Alias | Command |
|-------|---------|
| `v` | `nvim` |
| `t` | `tmux` |
| `gs` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `gd` | `git diff` |
| `glog` | `git log --oneline --graph` |
| `..` | `cd ..` |
| `...` | `cd ../..` |

---

## Daily Usage

### Sync Changes to Git

```bash
cd ~/dotfiles
git add -A
git commit -m "Update config"
git push
```

### Pull Changes on Another Machine

```bash
cd ~/dotfiles
git pull
# Changes apply immediately via symlinks
```

### Add a New Config

```bash
# Move config into dotfiles
mv ~/.config/newapp ~/dotfiles/.config/newapp

# Recreate symlinks
cd ~/dotfiles
stow -R .

# Commit
git add -A && git commit -m "Add newapp config"
```

---

## Troubleshooting

**"cannot stow ... existing target"**

A file already exists. Remove it first:
```bash
rm ~/.bashrc  # or whatever file conflicts
stow .
```

**Neovim plugins not loading**

```bash
rm -rf ~/.local/share/nvim/lazy
nvim  # Reinstalls plugins
```

**Icons showing as boxes**

Your terminal isn't using the Nerd Font. Set it to "JetBrainsMono Nerd Font" in terminal preferences.

**LSP not working**

Open Neovim and run `:Mason` to check/install language servers.
