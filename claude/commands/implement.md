# IMPLEMENT フェーズ

# ユーザの入力
#$ARGUMENTS

## 目的
plan.mdに基づきタスク単位で実装を行う。Draft PRを継続的に更新する。

## 注意事項
- 常にultrathinkでしっかりと考えて作業を行うこと
- コード中に絵文字は使用されるべきではありません。

## 必要な入力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/plan/{TIMESTAMP}_{TITLE}.md` - 実装計画書
- GitHub Issues（もしあれば）
- 関連する既存ファイル・コード

## タスクに含まれるべきTODO
1. ユーザの指示を理解し、実装開始をコンソールで通知
2. 最新の `~/.claude/docs/{REPOSITORY_NAME}/plan/{TIMESTAMP}_{TITLE}.md` ファイルを読み込み、実装計画を確認
3. 現在のブランチを確認し、適切なブランチにいることを確認
4. プランに従った実装を段階的に実行
5. `@ai-rules/COMMIT_AND_PR_GUIDELINES.md`に従ったコミット
6. Draft PRを作成または更新（初回実装時は作成、継続時は更新）
7. 実装内容の詳細を `~/.claude/docs/{REPOSITORY_NAME}/implement/{TIMESTAMP}_{TITLE}.md` に記録
8. 実装完了とファイル保存に関して`afplay /System/Library/Sounds/Funk.aiff`を実行しユーザに通知
9. 関連するplanファイル、実装詳細ファイル、PR番号をコンソール出力
10. ユーザのアクションが必要な時は`afplay /System/Library/Sounds/Glass.aiff`を実行し通知

## ブランチ・コミット規則
- ブランチ命名: `@ai-rules/COMMIT_AND_PR_GUIDELINES.md` に準拠
- コミットメッセージ: 同ガイドラインに従う
- 小粒コミット: タスク単位で適切に分割
- Draft PR: 実装初回時は作成、継続時は更新
- Pushするときは必ずユーザにpushするかどうか許諾を取る


## 出力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/implement/{TIMESTAMP}_{TITLE}.md` - 実装詳細記録
- 実装の意図など参考情報をわかりやすく記載してください

## 最終出力形式
- 必ず以下の三つの形式で出力を行ってください

### 実装完了の場合
status: SUCCESS
next: TEST
details: "実装完了。~/.claude/docs/{REPOSITORY_NAME}/implement_{TIMESTAMP}.mdに詳細記録。テストフェーズへ移行。"

### 追加作業が必要な場合
status: NEED_MORE
next: IMPLEMENT
details: "依存関係の実装が必要。~/.claude/docs/{REPOSITORY_NAME}/implement_{TIMESTAMP}.mdに詳細記録。タスク継続。"

### プラン見直しが必要な場合
status: NEED_REPLAN
next: PLAN
details: "設計変更が必要。~/.claude/docs/{REPOSITORY_NAME}/implement_{TIMESTAMP}.mdに詳細記録。プランフェーズに戻る。"
