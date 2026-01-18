# ⚡ My Neovim Configuration

A personalized Neovim setup focused on speed, aesthetics, and a seamless
development workflow.

## ✨ Features

* **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) for fast startup and easy management.
* **LSP:** Built-in LSP support with `mason.nvim` for easy server installation.
* **Treesitter:** Advanced syntax highlighting and code parsing.
* **Telescope:** Fuzzy finding for files, buffers, and grep.
* **UI:** Clean aesthetics with custom statusline and bufferline.

## 🛠️ Installation

To use this configuration, ensure you have **Neovim 0.11.2+** installed.

1. **Backup your current config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak

2. **Clone this repository**:
   ```bash
   git clone [https://github.com/vishvanatarajan/nvim-config.git](https://github.com/vishvanatarajan/nvim-config.git) ~/.config/nvim
   ```

3. **Launch:**
   ```bash
   nvim
   ```

Lazy.nvim will automatically install plugins on the first run.

## 📦 Requirements

To ensure all features (like fuzzy finding and syntax highlighting) work
correctly, please install the following on your local machine:

* **Ripgrep**: Required for Telescope's live grep functionality.
* **Nerd Fonts**: Highly recommended for file icons (e.g., JetBrainsMono Nerd Font).
* **C Compiler**: `gcc`, `cc`, or `clang` is required for Treesitter parsers.
* **Node.js & npm**: Often required for various language servers.

## 🧠 LSP (Language Server Protocol)

This configuration utilizes Neovim's **native LSP client** via `vim.lsp.enable()`
for a lightweight and high-performance development experience.

> [!IMPORTANT]
> **Manual Installation Required:**
This config does not automatically install binaries.
You must have the relevant Language Servers installed on your local machine's
`$PATH` for them to be detected.

### How to add a new language:
1. Install the server via your package manager
   (e.g., `brew install pyright` or `npm install -g typescript-language-server`).
2. The configuration will automatically pick up the server if it is available
   in your environment.
