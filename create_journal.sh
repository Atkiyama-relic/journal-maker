#!/bin/bash

# 環境変数から本名を取得
FULL_NAME=${FULL_NAME}

# 現在の日付を取得
TODAY=$(date +"%Y/%m/%d")
YYYY=$(date +"%Y")
MM=$(date +"%m")
DD=$(date +"%d")
WEEKDAY=$(date +"(%a)")  # 曜日を短縮形で取得

# フォルダパスとファイル名を定義
FOLDER="${YYYY}/${MM}"
FILENAME="${YYYY}${MM}${DD}.md"
FILEPATH="${FOLDER}/${FILENAME}"

# フォルダが存在しない場合は作成
if [ ! -d "$FOLDER" ]; then
  mkdir -p "$FOLDER"
fi

# ファイルが既に存在するか確認
if [ -f "$FILEPATH" ]; then
  read -p "ファイル $FILEPATH は既に存在します。上書きしますか？ (y/n): " CONFIRM
  if [ "$CONFIRM" != "y" ]; then
    echo "ファイルの作成をキャンセルしました。"
    exit 0
  fi
fi

# ファイルを作成し、内容を書き込む
cat <<EOL > "$FILEPATH"
${YYYY}/${MM}/${DD}${WEEKDAY} ${FULL_NAME}
◆活動内容
◆気付き
◆その他
EOL

echo "ファイルが作成されました: $FILEPATH"
