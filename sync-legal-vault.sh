#!/bin/bash

echo "🔄 Syncing Joplin → Legal Vault..."

# Switch sync path if needed (via desktop app)
joplin sync

# Run your dashboard builder
~/Wallace-Legal-Vault/sort-legal-vault.sh

# Git commit and push
cd ~/Wallace-Legal-Vault
git add .
git commit -m "Legal vault dashboard: $(date +'%Y-%m-%d')"
git push

echo "✅ Legal vault sorted and dashboard synced."
