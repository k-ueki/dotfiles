# QUERY Command

# ユーザの入力
#$ARGUMENTS 

## 目的
背景・要件・制約の把握を行い、正確なSQLを出力する。

## 注意事項
- 関連するコードおよびテーブル構造は全て読み、正確に把握すること。
- 全ての処理においてultrathinkでしっかりと考えて作業を行うこと。
- ファイルへの記述において絵文字を使用しないこと。

## 前提コンテキスト
- アプリケーションコードは~/CyberAgent/Dynalyst/conv-appsにあります。十分に理解した上で回答して下さい。
- 下記のクエリの結果(テーブル構造)を`~/.claude/docs/table_schema/2025-10-27_table_schema.csv`に置いているので、各テーブルの構造と紐づきを正確に把握すること。
    ```
      SELECT
          t.table_name,
          c.column_name,
          c.data_type,
          c.is_nullable,
          c.column_default,
          c.character_maximum_length,
          c.numeric_precision,
          c.numeric_scale
      FROM information_schema.tables t
      JOIN information_schema.columns c
          ON t.table_schema = c.table_schema
          AND t.table_name = c.table_name
      WHERE 
          t.table_name NOT LIKE '%TMP%'
          AND t.table_name NOT LIKE '%PRIVACY_SANDBOX%'
          AND t.table_name NOT LIKE '%KK%'
          AND t.table_name NOT LIKE '%TK%'
      ORDER BY t.table_name, c.ordinal_position;
    ```
- わからないことは都度ユーザに確認すること。

## 各テーブルの説明
- RD_LOG: 配信したADにおいて、CLICKが発生した際にRD_SERVERにリクエストが飛び、RD_LOGにそのログが出力される。

## タスクに含まれるべきTODO
1. 調査対象・スコープを明確化
2. 関連ファイル・ログ・ドキュメントを収集し、体系的に分析
3. 調査結果を文書化し、`~/.claude/docs/{REPOSITORY_NAME}/query/{TIMESTAMP}_{TITLE}.md`に保存。ただし、最終的なSQLをわかりやすく結論として冒頭に記述すること。思考プロセスもファイルに出力すること。
4. 調査完了とファイル保存に関して`afplay /System/Library/Sounds/Funk.aiff`を実行しユーザに通知
5. 作成した調査結果ファイル名をコンソール出力
6. ユーザのアクションが必要な時は`afplay /System/Library/Sounds/Glass.aiff`を実行し通知

## 出力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/query/{TIMESTAMP}_{TITLE}.md`
- TITLEは極力簡潔にまとめること

## 最終出力形式
- 必ず以下の二つの形式で出力を行ってください

### 調査完了の場合
status: COMPLETED
details: "調査完了。出力先: {OUTPUT_FILE_NAME} クエリ結果: {QUERY_RESULT}"

