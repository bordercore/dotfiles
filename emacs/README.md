# Emacs Configuration

A comprehensive Emacs configuration managed using Org-mode literate programming. The configuration is documented in [emacs.org](emacs.org), which is automatically compiled to `init.el` when Emacs starts.

## Overview

This configuration provides a modern, feature-rich Emacs setup optimized for software development, writing, and general text editing. It emphasizes performance, usability, and extensibility through the use of modern packages and best practices.

## Key Features

### Performance & Initialization

- Optimized garbage collection threshold for improved LSP performance
- Increased process output buffer size for better LSP communication
- Emacs server auto-start for faster client connections
- Native compiler warning suppression
- Support for local customization files (`local.el` and `~/.emacs-local`)

### Package Management

- **use-package**: Declarative package management with automatic installation
- **MELPA & MELPA-stable**: Primary package archives
- **Paradox**: Modernized package menu with GitHub integration

### User Interface

- **Themes**: Dynamic theme loading via `EMACS_THEME` environment variable
- **Spaceline**: Spacemacs-style mode-line
- **Visual enhancements**: 
  - Maximized frames on startup
  - Whitespace visualization (trailing whitespace and tabs)
  - Visual line mode for word-wrapped text
  - Custom font configuration
- **Mouse support**: Full mouse wheel and scroll bar integration

### Editing & Text Manipulation

- **YASnippet**: Template system for code snippets
- **expand-region**: Incremental text selection expansion
- **Whole line or region**: Consistent behavior for operations on lines or regions
- **unfill-paragraph**: Convert multi-line paragraphs to single lines
- **Custom line duplication**: F12 key binding

## Navigation & Completions

### Completions

- **Ivy**: Powerful completion framework with fuzzy matching
- **Counsel**: Ivy-enhanced versions of common Emacs commands
- **Swiper**: Enhanced isearch with Ivy

### Project Management

- **Projectile**: Project navigation, file finding, and management
- **Imenu**: Quick navigation to definitions within files
- **Treemacs**: File tree sidebar for project navigation

### File Management

- **Dired**: Enhanced directory browser with custom key bindings
- **Ibuffers**: Enhanced buffer management interface

### Search

- Project-wide search with `projectile-ag` (bound to F4)
- Enhanced isearch with Swiper
- Query-replace bound to F2

## Org Mode

Comprehensive Org-mode configuration for writing, note-taking, and task management:

- **Todo management**: Custom todo keywords and workflow
- **Visual enhancements**: 
  - Org-bullets for prettier list markers
  - Org-fancy-priorities with custom priority strings
  - Org-appear for showing emphasis markers on hover
- **Auto-show emphasis markers**: Improved editing experience with hidden markup

## Development Tools

### Language Server Protocol (LSP)

- **lsp-mode**: Full LSP support with automatic server management
- **lsp-ui**: Enhanced UI for LSP features (hover, diagnostics, breadcrumbs)
- **lsp-pyright**: Python language server
- **lsp-ivy**: Ivy integration for LSP commands
- Configured for TypeScript, JavaScript, and Python

### Python Development

- **Pyright**: Type checking and language server
- **py-isort**: Automatic import sorting on save
- **pyvenv**: Virtual environment management
- **dap-mode**: Debug adapter protocol for debugging Python
- **Flycheck**: On-the-fly syntax checking with posframe popups
- Custom PYTHONPATH configuration for Django projects
- Trusted project paths for directory-local variables

### Web Development

- **web-mode**: Major mode for HTML templates (Django, Vue.js)
- **highlight-indent-guides**: Visual indentation guides
- **CSS mode**: Enhanced CSS editing with C-style indentation
- **Rainbow mode**: Color preview in CSS files
- Configured for Django templates and Vue.js single-file components

### Version Control

- **Magit**: Comprehensive Git interface
  - Full-screen magit-status with window configuration saving
  - Custom key binding (C-x g)
  - Custom quit function (q) that restores window layout
  - Process buffer auto-display on errors

### Code Quality

- **Flycheck**: Real-time syntax checking
- **Flycheck-posframe**: Non-intrusive error display
- ESLint integration for JavaScript/TypeScript
- Pylint support with custom configuration

### Language Support

- **C/C++**: K&R style with 4-space indentation
- **Perl**: cperl-mode with custom indentation
- **SQL**: PostgreSQL keyword highlighting
- **JSON**: json-mode for JSON files
- **YAML**: YAML mode support
- **Lisp**: Enhanced font-lock keywords

## AI Tools

### ChatGPT Integration

- **chatgpt-shell**: Interactive ChatGPT interface
- Spell check and grammar correction (C-c s)
- Clarity improvement for paragraphs
- Custom prompt support for text editing
- Git commit message generation from staged diffs

### Codeium

- AI-powered code completion
- Global or mode-specific activation

## External Tools & Integration

- **atomic-chrome**: Edit Chrome textareas directly in Emacs via GhostText protocol
- **Games**: Nethack integration with custom key bindings

## Key Bindings

- **F1**: Open org files directory in Dired
- **F2**: Query replace
- **F4**: Project-wide search (projectile-ag)
- **F5**: Revert buffer without confirmation
- **F6**: Switch window configurations (registers)
- **F8**: Projectile find file
- **F9**: Evaluate region
- **F12**: Duplicate current line
- **C-x g**: Magit status
- **C-x arrow keys**: Window navigation
- **C-=": Expand region
- **C-c s**: ChatGPT spell check/improve (text mode) or commit message (git-commit mode)
- **Home/End**: Beginning/end of buffer

## Customization

The configuration supports local customization through:

- `~/.emacs.d/local.el`: Local configuration file (not tracked in git)
- `~/.emacs-local`: Additional local settings
- Environment variable `EMACS_THEME`: Set the Emacs theme name
- Directory-local variables: Supported with trusted project paths

## Files

- **emacs.org**: Main configuration file (literate programming format)
- **init.el**: Auto-generated from emacs.org via org-babel
- **abbrev_defs**: Abbreviation definitions
- **.emacs-modeline**: Custom mode-line configuration

For detailed documentation of all settings and packages, see [emacs.org](emacs.org).

