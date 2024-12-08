# List available commands
default:
    just --list --unsorted

# Start notebook
start-notebook:
    #!/bin/zsh

    . .venv/bin/activate
    jupyter lab --allow-root

# Lint code
lint:
    #!/bin/zsh

    . .venv/bin/activate
    ruff check .

# Lint and fix any issues that can be fixed automatically
lint-fix:
    #!/bin/zsh

    . .venv/bin/activate
    ruff check . --fix

# Format code
format:
    #!/bin/zsh

    . .venv/bin/activate
    ruff format .

# Install modules
install-modules:
    #!/bin/zsh

    . "$HOME/.rye/env" || true

    rye sync

# Prepare project to work with
prepare: install-modules

# Bootstrap project
bootstrap: install-rye prepare setup-pre-commit

# Set up dev container. This step runs after building the dev container
post-dev-container-create:
    just .devcontainer/post-create
    just bootstrap

[private]
install-rye:
    #!/bin/zsh

    . ~/.zshrc

    curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes"  bash

    . "$HOME/.rye/env"

    mkdir -p ~/.zfunc
    rye self completion -s zsh > ~/.zfunc/_rye

    if [[ -n $ZSH_CUSTOM ]]
    then
        mkdir -p $ZSH_CUSTOM/plugins/rye
        rye self completion -s zsh > $ZSH_CUSTOM/plugins/rye/_rye
    fi

[private]
setup-pre-commit:
    #!/bin/zsh

    . .venv/bin/activate
    pre-commit install
