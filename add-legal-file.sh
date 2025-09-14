#!/bin/bash
vault=~/Wallace-Legal-Vault
cd "$vault"
DATE=$(date +%Y-%m-%d)
TS=$(date +%Y-%m-%d-%H%M)
log="$vault/legal.log"
entry="$vault/03 - Breaches/Breach-${DATE}.md"
folder="$vault/04 - Evidence"

read -p "Path to file (PDF or image): " filepath
read -p "Description of file: " description

ext="${filepath##*.}"
newname="evidence-${TS}.${ext}"
mv "$filepath" "$folder/$newname"

echo "- 📎 $description ([${newname}](../04 - Evidence/${newname}))" >> "$entry"
echo "$(date) - Added file: $description → $newname" >> "$log"

git add "$folder/$newname" "$entry" "$log"
git commit -m "Added legal file: $description"
git push
echo "✅ File added, logged, and synced."
