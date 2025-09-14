#!/bin/bash
vault=~/Wallace-Legal-Vault
cd "$vault"
DATE=$(date +%Y-%m-%d)
log="$vault/legal.log"
file="$vault/03 - Breaches/Breach-${DATE}.md"

read -p "Legal update: " input

if [[ "$input" == *"remove"* ]]; then
  target="${input/remove /}"
  grep -rl "$target" "$vault/01 - Handovers/" "$vault/02 - Wellbeing/" "$vault/03 - Breaches/" | xargs rm -v
  echo "$(date) - Removed: $target" >> "$log"
else
  echo "- $input" >> "$file"
  echo "$(date) - Added: $input" >> "$log"
fi

git add .
git commit -m "Legal update: $input"
git push
echo "✅ Legal vault updated and synced."
