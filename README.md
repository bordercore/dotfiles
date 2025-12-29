# Dotfiles

Personal dotfiles configuration managed with [GNU stow](https://www.gnu.org/software/stow/manual/stow.html).

## Overview

This repository contains configuration files for various command-line tools and applications, organized using GNU stow for easy management and deployment across multiple systems.

### Included Configurations

- **bash** - Bash shell configuration (`.bashrc`, prompt, dir colors)
- **zsh** - Zsh shell configuration (`.zshrc`, prompt, dir colors)
- **emacs** - Comprehensive Emacs configuration including LSP, org-mode, and development tools
- **git** - Git configuration with aliases, colors, and delta integration
- **tmux** - Terminal multiplexer configuration
- **less** - Pager configuration and filters
- **psql** - PostgreSQL client configuration
- **top** - System monitor configuration
- **python** - MyPy type checker configuration - *not installed by default*
- **elisp** - Custom Emacs Lisp packages
- **bash-osx** - macOS-specific utilities (installed to `~/bin`)

## Prerequisites

This repository requires [GNU stow](https://www.gnu.org/software/stow/) to manage symlinks.

### Installing GNU stow

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get install stow
```

**Linux (Fedora/RHEL):**
```bash
sudo dnf install stow
```

**macOS:**
```bash
brew install stow
```

**macOS (MacPorts):**
```bash
sudo port install stow
```

## Installation

> **Warning:** This will create symlinks that may overwrite existing dotfiles in your home directory. Please back up your current configuration files before proceeding.

### Quick Install

Run the provided installation script:

```bash
./install.sh
```

### Manual Installation

You can install configurations individually or all at once using stow commands:

```bash
# Install all configurations
stow -t $HOME bash
stow -t $HOME zsh
stow -t $HOME/.emacs.d/ emacs
stow -t $HOME git
stow -t $HOME less
stow -t $HOME psql
stow -t $HOME tmux
stow -t $HOME top
stow -t $HOME/bin bash-osx

# Or install specific configurations only
stow -t $HOME git
stow -t $HOME tmux
```

### Installing Optional Configurations

Configurations not included in `install.sh` can be installed manually:

```bash
# Install python configuration (MyPy)
stow -t $HOME python
```

## Repository Structure

Each directory in this repository corresponds to a configuration package that stow will symlink to your home directory:

```
dotfiles/
├── bash/           → ~/.bashrc, ~/.prompt, ~/.dir_colors, etc.
├── zsh/            → ~/.zshrc, ~/.zprompt, ~/.zdir_colors
├── emacs/          → ~/.emacs.d/init.el, ~/.emacs.d/emacs.org, etc.
├── git/            → ~/.gitconfig, ~/.gitconfig.local
├── tmux/           → ~/.tmux.conf
├── less/           → ~/.lessfilter
├── psql/           → ~/.psqlrc
├── top/            → ~/.toprc
├── python/         → ~/mypy.ini
├── elisp/          → ~/.emacs.d/elisp/ (referenced by Emacs config)
├── bash-osx/       → ~/bin/pbpaste.swift
└── install.sh      Installation script
```

## Customization

### Modifying Configurations

Edit the configuration files directly in this repository. The changes will be immediately available since stow creates symlinks.

### Adding New Configurations

1. Create a new directory for your configuration:
   ```bash
   mkdir myconfig
   ```

2. Add your configuration files to the directory:
   ```bash
   myconfig/
   └── .myconfigrc
   ```

3. Install using stow:
   ```bash
   stow -t $HOME myconfig
   ```

4. Optionally, add it to `install.sh` for future installations.

### Excluding Configurations

To remove a configuration:

```bash
stow -D -t $HOME bash  # Remove bash configuration
```

To uninstall all configurations:

```bash
stow -D -t $HOME bash emacs git less psql tmux top
stow -D -t $HOME/.emacs.d/ emacs
stow -D -t $HOME/bin bash-osx
```

### Local Overrides

Some configurations support local overrides:

- **Git**: Create `~/.gitconfig.local` to override or extend settings (see `git/.gitconfig.local.example`)

## Credits

This dotfiles setup was inspired by:

- [sidsarasvati/dotfiles](https://github.com/sidsarasvati/dotfiles)
- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

For more information about GNU stow, see the [official documentation](https://www.gnu.org/software/stow/manual/stow.html).
