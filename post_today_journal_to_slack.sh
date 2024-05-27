#!/bin/bash

# .envファイルを読み込む
if [ -f .env ]; then
  export $(cat .env | xargs)
else
  echo ".envファイルが見つかりません。"
  exit 1
fi

# 環境変数から必要な情報を取得
SLACK_API_TOKEN=${SLACK_API_TOKEN}
SLACK_CHANNEL_ID=${SLACK_CHANNEL_ID}

# 環境変数の確認
if [ -z "$SLACK_API_TOKEN" ] || [ -z "$SLACK_CHANNEL_ID" ]; then
  echo "SLACK_API_TOKEN または SLACK_CHANNEL_ID が設定されていません。"
  exit 1
fi

# 現在の日付を取得
YYYY=$(date +"%Y")
MM=$(date +"%m")
DD=$(date +"%d")

# 当日のジャーナルファイルパスを定義
FOLDER="${YYYY}/${MM}"
FILENAME="${YYYY}${MM}${DD}.md"
FILEPATH="${FOLDER}/${FILENAME}"

# ファイルが存在するか確認
if [ ! -f "$FILEPATH" ]; then
  echo "当日のジャーナルファイルが見つかりません: $FILEPATH"
  exit 1
fi

# ファイルの内容を読み込む
REPORT_CONTENT=$(cat "$FILEPATH")

# 投稿内容を表示して確認
echo "以下の内容をSlackに投稿します："
echo "-----------------------------------"
echo "$REPORT_CONTENT"
echo "-----------------------------------"
read -p "この内容を投稿しますか？ (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
  echo "投稿をキャンセルしました。"
  exit 0
fi

# Slackに投稿
RESPONSE=$(curl -X POST -H "Authorization: Bearer ${SLACK_API_TOKEN}" -H 'Content-type: application/json' \
--data "{\"channel\":\"${SLACK_CHANNEL_ID}\",\"text\":\"\`\`\`\n${REPORT_CONTENT}\n\`\`\`\"}" \
https://slack.com/api/chat.postMessage)

# レスポンスを確認
if echo "$RESPONSE" | grep -q '"ok":true'; then
  echo "Slackへの投稿が成功しました。"
else
  echo "Slackへの投稿に失敗しました。レスポンス: $RESPONSE"
fi
