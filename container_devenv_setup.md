# Devcontainer + Neovim + Docker Compose Setup

## Project Structure
```
your-project/
├── docker-compose.yml
├── justfile
├── .devcontainer/
│   └── nvim/
│       ├── devcontainer.json
│       └── setup.sh
```

## devcontainer.json
```json
{
  "name": "Spark Iceberg Development", # Replace with your development environment name
  "dockerComposeFile": "../../docker-compose.yml",
  "service": "airflow-spark", # Replace with the docker service that you want nvim to run within
  "workspaceFolder": "/home/airflow", # Replace with your docker's home or code dir 
  "shutdownAction": "stopCompose",

  "mounts": [
    // Mount local nvim config - changes reflect immediately, no copying needed
    "source=${localEnv:HOME}/.config/nvim,target=/root/.config/nvim,type=bind,readonly",
    // Mount .devcontainer so postCreateCommand can find setup.sh
    "source=${localWorkspaceFolder}/.devcontainer,target=/devcontainer,type=bind,readonly"
  ],

  "postCreateCommand": "bash /devcontainer/nvim/setup.sh"
}
```

## setup.sh
```bash
#!/bin/bash
set -e

# Install nvim (apt version is too old on debian/bookworm, use official binary)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc

# System tools (checked against :checkhealth output)
apt-get update && apt-get install -y \
  curl git gcc unzip \
  ripgrep fd-find xclip \
  nodejs npm \
  python3 python3-pip

# Python LSP tools via uv (ruff not in mason, must be installed separately)
export PATH="$HOME/.local/bin:$PATH"
uv tool install ruff
uv tool install pyright

# Persist PATH for nvim sessions
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

## justfile
```just
# List available commands
default:
    just --list

# Docker compose up
docker-up:
    docker compose up -d

# Docker compose down
docker-down:
    docker compose down

# Start devcontainer
dev-up:
    devcontainer up --workspace-folder . --config .devcontainer/nvim/devcontainer.json

# Stop devcontainer
dev-down:
    devcontainer down --workspace-folder . --config .devcontainer/nvim/devcontainer.json

# Open nvim inside container, run as uv if you have setup uv python libraries
nvim *args:
    devcontainer exec --workspace-folder . --config .devcontainer/nvim/devcontainer.json uv run nvim {{args}}
```

## Key Learnings

**devcontainer.json**
- `forwardPorts` is unnecessary if docker-compose already defines ports
- Use `${localEnv:HOME}` instead of `~` for host paths in mounts
- Use `${localWorkspaceFolder}` to reference project root on host
- Multiple configs supported via subfolders + `--config` flag
- `shutdownAction: stopCompose` stops all services when done

**Neovim config**
- Mount nvim config as bind mount instead of copying — changes reflect immediately
- Plugin data (lazy.nvim, mason) lives inside container and resets on rebuild — acceptable since reinstall is fast
- Mason auto-installs LSPs on first launch via `ensure_installed`
- `ruff` is installed via pip/uv, not mason — check `mason/bin` vs `:LspInfo` to find gaps
- Use `:checkhealth` to get the exact list of required system tools
- Debian bookworm apt neovim is too old — always use the official binary

**CLI commands**
- `devcontainer up` starts compose + runs postCreateCommand
- `devcontainer down` runs docker compose down
- `devcontainer exec` attaches and runs a command (nvim, bash, etc)
- First `dev-up` is slow due to setup.sh — subsequent runs are fast
