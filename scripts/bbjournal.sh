#!/bin/bash

REPO="$HOME/Bug-Bounty-Research-Journal"
cd "$REPO" || exit 1

echo "================================"
echo "     DAILY BUG BOUNTY JOURNAL"
echo "================================"

read -rp "Date (DD-MM-YYYY): " DATE
read -rp "Target / Program: " TARGET
read -rp "Hours hunted: " HOURS

echo
echo "What did you work on today?"
read -rp "> " WORK

echo
echo "Testing results:"
read -rp "> " RESULT

echo
echo "What did you learn?"
read -rp "> " LEARNING

echo
echo "Next day plan:"
read -rp "> " NEXT

MONTH=$(date -d "$(echo "$DATE" | awk -F- '{print $3"-"$2"-"$1}')" +%Y-%m 2>/dev/null)

if [ -z "$MONTH" ]; then
    echo "Invalid date. Use DD-MM-YYYY."
    exit 1
fi

FILE="$MONTH/$DATE.md"

if [ -f "$FILE" ]; then
    echo "Journal already exists: $FILE"
    exit 1
fi

mkdir -p "$MONTH"

cat > "$FILE" <<EOT
# Daily Hunting Journal — $DATE

## Target
$TARGET

## Time Invested
$HOURS hours

## Work Done
$WORK

## Results
$RESULT

## What I Learned
$LEARNING

## Next Day Plan
$NEXT
EOT

echo
echo "Journal saved: $FILE"

git add "$FILE"

git commit -m "Hunting log - $DATE" || exit 1

git push origin main

echo
echo "Journal successfully pushed to GitHub!"
