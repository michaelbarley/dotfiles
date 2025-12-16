# Neovim Configuration

## Installation

### 1. Remove Existing Neovim Configuration

```bash
# Backup your current config (optional)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup

# Or completely wipe everything
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

### 2. Clone This Configuration

```bash
git clone git@github.com:michaelbarley/neovimrc.git ~/.config/nvim
```

### 3. Install Dependencies

Make sure you have these installed:
- Neovim >= 0.9.0
- Git
- A C compiler (macOS: `xcode-select --install`)
- A Nerd Font (for icons)
- ripgrep (for Telescope live grep)
- Node.js (for LSP servers)
- prettier (`npm install -g prettier`)
- stylua (`brew install stylua`)

### 4. Launch Neovim

```bash
nvim
```

On first launch, plugins will automatically install. LSP servers and formatters will be installed through Mason when you open relevant file types.
