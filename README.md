# 日報作成スクリプト

このシェルスクリプトは、現在の日付に基づいて指定されたフォルダとMarkdownファイルを作成し、テンプレートを埋め込むものです。環境変数から取得した本名をファイルに含めます。

# Slack Journal Posting App

このアプリは、日報をSlackに投稿するためのシェルスクリプトです。

## 使用方法

### 前提条件

- Unix系OS (Linux, macOSなど)
- SlackアプリのAPIトークン
- SlackチャンネルID

### セットアップ

1. リポジトリをクローンします：

    ```bash
    git clone https://github.com/Atkiyama-relic/journal-maker.git
    cd journalMaker
    ```

2. `.env.template` を `.env` にコピーし、必要な情報を入力します：

    ```bash
    cp .env.template .env
    ```

3. スクリプトに実行権限を与えます：

    ```bash
    chmod 775 *.sh
    ```

### 使用方法

1. 日報ファイルを作成します。
    ```bash
    ./create_journal.sh
    ```

2. スクリプトを実行して日報をSlackに投稿します：

    ```bash
    ./post_today_journal_to_slack.sh
    ```

### 環境変数

`.env` ファイルには以下の変数を設定します：

- `FULL_NAME`: あなたの名前
- `SLACK_API_TOKEN`: Slack APIトークン
- `SLACK_CHANNEL_ID`: 投稿先のSlackチャンネルID

slack apiトークンとチャンネルIDは連絡くれたら教えるので連絡ください

```
## 出力されるもの

yyyy/mm/yyyymmdd.mdというファイルが作成され、以下の内容が出力されます

```md:
yyyy/mm/dd（曜日）本名 太郎
◆活動内容
◆気付き
◆その他

```
