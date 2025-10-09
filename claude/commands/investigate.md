# INVESTIGATE フェーズ

# ユーザの入力
#$ARGUMENTS 

## 目的
背景・要件・制約の把握を行い、実装の方向性を決定する。

## 注意事項
- 関連するコードは全て読むこと。
- 全ての処理においてultrathinkでしっかりと考えて作業を行うこと。
- ファイルへの記述において絵文字を使用してはいけません。

## タスクに含まれるべきTODO
1. 調査対象・スコープを明確化
2. 現在のブランチ状況を確認し、`feature/<topic>` ブランチを作成
3. 関連ファイル・ログ・ドキュメントを収集し、体系的に分析
4. 技術的制約・可能性を調査
5. 既存システムとの整合性を確認
6. 問題の根本原因・解決方針を特定
7. 調査結果を文書化し、`~/.claude/docs/{REPOSITORY_NAME}/investigate/{TIMESTAMP}_{TITLE}.md`に保存
8. 次フェーズ（Plan）への推奨事項を提示
9. 調査完了とファイル保存に関して`afplay /System/Library/Sounds/Funk.aiff`を実行しユーザに通知
10. 作成したブランチ名、調査結果ファイル名をコンソール出力
11. ユーザのアクションが必要な時は`afplay /System/Library/Sounds/Glass.aiff`を実行し通知

## ブランチ作成規則
- ブランチ命名: `feature/<topic>` または `fix/<issue>`
- 必ず最新の `master` ブランチから作成
- ブランチ作成後はそのブランチで全作業を継続
- ブランチを作成する際は必ず最新のmasterを使うこと

## 出力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/investigate/{TIMESTAMP}_{TITLE}.md`
- TITLEはできるだけ簡潔にまとめること

## 最終出力形式
- 必ず以下の二つの形式で出力を行ってください

### 調査完了（実装推奨）の場合
status: COMPLETED
next: PLAN
details: "調査完了。feature/<topic>ブランチ作成済み。~/.claude/docs/{REPOSITORY_NAME}/investigate/investigate_{TIMESTAMP}.mdに詳細を記述。実装方針策定を推奨。"

### 調査完了（実装不要）の場合
status: COMPLETED
next: NONE
details: "調査完了。~/.claude/docs/{REPOSITORY_NAME}/investigate/investigate_{TIMESTAMP}.mdに詳細を記述既存機能で対応可能。実装・変更は不要。"
