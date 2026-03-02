# ⚡ My Neovim Configuration

A personalized Neovim setup focused on speed, aesthetics, and a seamless
development workflow.

## ✨ Features

- **Plugin Manager:** https://github.com/folke/lazy.nvim for fast startup and easy management.
- **LSP:** LSP support using in-built `vim.lsp.enable`.
- **Treesitter:** Advanced syntax highlighting and code parsing.
- **Telescope:** Fuzzy finding for files, buffers, and grep.
- **UI:** Clean aesthetics with custom statusline and bufferline.

## 🛠️ Installation

To use this configuration, ensure you have **Neovim 0.11.2+** installed.

1. **Backup your current config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/vishvanatarajan/nvim-config.git ~/.config/nvim
   ```

3. **Launch:**
   ```bash
   nvim
   ```
   *lazy.nvim* will automatically install plugins on the first run.

## 📦 Requirements

To ensure all features (like fuzzy finding and syntax highlighting) work
correctly, please install the following on your local machine:

- **Ripgrep**: Required for Telescope's live grep functionality.
- **fd**: Required for Telescope's file finding functionality.
- **tree-sitter-cli**: Required for `nvim-treesitter` to generate parsers from grammars.
- **Nerd Fonts**: Highly recommended for file icons (e.g., JetBrainsMono Nerd Font).
- **C Compiler**: `gcc`, `cc`, or `clang` is required for Treesitter parsers.
- **Node.js & npm**: Often required for various language servers.

### 🖱️ System Clipboard Integration (Linux & WSL)

This config expects a working **system clipboard** so operations like `"+y` / `"+p` interoperate with your OS. Neovim relies on an **external provider**—install the one appropriate to your environment:

#### Linux — Wayland sessions
Install **wl-clipboard** (provides `wl-copy` / `wl-paste`):
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install wl-clipboard
# Fedora/RHEL
sudo dnf install wl-clipboard
# Arch/Manjaro
sudo pacman -S wl-clipboard
```

#### Linux — X11 sessions
Install **xclip** or **xsel** (either is fine):
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install xclip xsel
# Fedora/RHEL
sudo dnf install xclip xsel
# Arch/Manjaro
sudo pacman -S xclip xsel
```

---

### 🪟 WSL 2 on Windows — `win32yank.exe` (recommended)

On **WSL 2**, the most reliable provider is **`win32yank.exe`**, which bridges Neovim to the Windows clipboard. You can obtain it in either of these ways:

1) **Via Neovim for Windows (bundled):**  
Installing Neovim on Windows places `win32yank.exe` in `C:\\Program Files\\Neovim\\bin`.

2) **Standalone download:**  
Download the latest `win32yank.exe` from the official releases and place it on your Windows system.

#### **WSL interop requirement**
To execute Windows binaries (including `win32yank.exe`) from WSL, enable interop in `/etc/wsl.conf` and then restart WSL:

```ini
# /etc/wsl.conf
[interop]
enabled = true
# You can keep PATH clean if you prefer:
appendWindowsPath = false
```

Apply changes from Windows PowerShell:
```powershell
wsl --shutdown
```

#### Expose `win32yank.exe` to WSL (keep Windows PATH clean)
If you keep `appendWindowsPath=false`, create a **symlink** so WSL can execute `win32yank.exe` without re‑adding the full Windows PATH:

```bash
# In WSL (Ubuntu)
mkdir -p ~/.local/bin

# Adjust the Windows path if needed; the example below uses Neovim for Windows' default install location:
ln -sf "/mnt/c/Program Files/Neovim/bin/win32yank.exe" ~/.local/bin/win32yank.exe

# Ensure ~/.local/bin is on your PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Verify in Neovim:**
- Run `:checkhealth` — the **Clipboard** section should list **win32yank** as the provider.
- Try `"+yy` in Neovim, then paste into a Windows app (e.g., Notepad) to confirm.

---

## 🧠 LSP (Language Server Protocol)

This configuration utilizes Neovim's **native LSP client** via `vim.lsp.enable()` for a lightweight and high-performance development experience.
Further, the LSP configurations are located in the lsp/ folder in the current configuration structure. Any LSP specific configuration must be
added there.

All LSPs are disabled by default and can be enabled by uncommenting the lsp.lua file in this configuration setup.

> **Manual Installation Required:**
> This config does not automatically install binaries.
> Ensure the relevant language servers are installed on your system and available on your `$PATH`.

### How to add a new language

1. Install the server via your package manager  
   (e.g., `brew install basedpyright` or `npm install -g typescript-language-server`).
2. The configuration will automatically pick up the server if it is available in your environment.
