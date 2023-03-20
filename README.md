# 🎯 Dotfiles

This repository contains MacOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

Install [Homebrew](https://brew.sh/) on MacOS.

## Install GNU Stow

```bash
brew install stow
```

## Commands

### Symlink dotfiles

```bash
make stow
```

### Symlink dotfiles with custom verbosity (0 to 4)

```bash
make stow-verbose VERBOSITY=1
```

### Dry-run (preview actions)

```bash
make dry-run
```

### Update symlinks and remove stale ones

```bash
make restow
```

### Remove symlinks

```bash
make delete
```
