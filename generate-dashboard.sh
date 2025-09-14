#!/bin/bash
vault=$(pwd)
DATE=$(date +%Y-%m-%d)
dashboard="$vault/00 - Dashboard/Dashboard-${DATE}.md"
log="$vault/dashboard.log"

mkdir -p "$vault/00 - Dashboard"
echo "# 📊 Vault Dashboard – $DATE" > "$dashboard"
echo "" >> "$dashboard"

for folder in "$vault"/*/; do
  fname=$(basename "$folder")
  echo "## 📁 $fname" >> "$dashboard"
  recent=$(ls -1t "$folder" 2>/dev/null | head -n 5)
  if [[ -z "$recent" ]]; then
    echo "_No recent files_" >> "$dashboard"
  else
    for file in $recent; do
      echo "- [$file]($folder$file)" >> "$dashboard"
    done
  fi
  echo "" >> "$dashboard"
done

echo "$(date) - Dashboard generated: $dashboard" >> "$log"
git add "$dashboard" "$log"
git commit -m "Dashboard generated: $DATE"
git push
echo "✅ Dashboard created and synced."
