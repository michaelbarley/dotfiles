# Dotfiles

My personal configuration files.

## Installation

Clone the repository:

```bash
git clone git@github.com:michaelbarley/dotfiles.git ~/dotfiles
```

### tmux

Symlink the tmux config to your home directory:

```bash
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
```

Reload tmux (if already running):

```bash
tmux source-file ~/.tmux.conf
```
