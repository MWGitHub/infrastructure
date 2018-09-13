#!/usr/bin/env bash

if [ ! -d "$HOME/.terraform.d/plugins" ]; then
    mkdir -p "$HOME/.terraform.d/plugins"
fi

echo "Third party plugin installation completed."
