#!/bin/bash
vault=~/Wallace-Legal-Vault
cd "$vault"
DATE=$(date +%Y-%m-%d)
dashboard="$vault/00 - Dashboard/Legal-Dashboard-${DATE}.md"
log="$vault/legal-scan.log"

mkdir -p "$vault/00 - Dashboard"
echo "# 📊 Legal Vault Dashboard – $DATE" > "$dashboard"
echo "" >> "$dashboard"

for folder in "$vault"/*/; do
  name=$(basename "$folder")
  echo "## 📁 $name" >> "$dashboard"
  files=$(find "$folder" -type f | sort -r | head -n 5)
  if [[ -z "$files" ]]; then
    echo "_No files found_" >> "$dashboard"
  else
    while IFS= read -r file; do
      rel="${file#$vault/}"
      echo "- [$rel]($rel)" >> "$dashboard"
    done <<< "$files"
  fi
  echo "" >> "$dashboard"
done

echo "$(date) - Legal vault scanned and dashboard created." >> "$log"
git add -f "$dashboard" "$log"
git commit -m "Legal vault dashboard: $DATE"
git push
echo "✅ Legal vault sorted and dashboard synced."
