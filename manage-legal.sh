#!/bin/bash
vault=~/Wallace-Legal-Vault
cd "$vault"
DATE=$(date +%Y-%m-%d)
log="$vault/legal.log"
file="$vault/03 - Breaches/Breach-${DATE}.md"

echo "Choose action: [add] [remove] [update]"
read -p "Action: " action
read -p "Entry: " input

case "$action" in
  add)
    echo "- $input" >> "$file"
    echo "$(date) - Added: $input" >> "$log"
    ;;
  remove)
    grep -rl "$input" "$vault/01 - Handovers/" "$vault/02 - Wellbeing/" "$vault/03 - Breaches/" | xargs rm -v
    echo "$(date) - Removed: $input" >> "$log"
    ;;
  update)
    echo "- UPDATE: $input" >> "$file"
    echo "$(date) - Updated: $input" >> "$log"
    ;;
  *)
    echo "❌ Invalid action. Use add, remove, or update."
    exit 1
    ;;
esac

git add .
git commit -m "Legal $action: $input"
git push
echo "✅ Legal vault $action complete and synced."
