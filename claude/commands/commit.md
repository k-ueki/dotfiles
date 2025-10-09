# COMMIT フェーズ

## 目的
実装内容をGITにコミットする。

## 必要な入力ファイル
- `docs/commit/{TIMESTAMP}_{BRANCH_NAME}.md` - コミット内容

## 注意事項
- 関連するコードは全て読むこと。
- 全ての処理においてultrathinkでしっかりと考えて作業を行うこと。

# ユーザの入力
#$ARGUMENTS


## タスクに含まれるべきTODO
1. ユーザの指示を理解する
2. 最新の `docs/investigate/{TIMESTAMP}_{TITLE}.md`, `docs/plan/{TIMESTAMP}_{TITLE}.md`, `docs/implement/{TIMESTAMP}_{TITLE}.md` を読み込み、調査・実装結果を確認
3. 実装内容や差分を全て読みこみ、内容を理解する
4. 適切な粒度で差分をCommitする。Commitメッセージにわかりやすく英語で端的に表すこと。Commitメッセージは小文字で始めること。
5. また、Commitメッセージごとにどのような差分をCommitしたか `docs/commit/{TIMESTAMP}_{BRANCH_NAME}.md` に出力すること。
6. pushはしないこと
7. 完了とファイル保存に関して`afplay /System/Library/Sounds/Funk.aiff`を実行しユーザに通知

## 出力ファイル
- `docs/review/{TIMESTAMP}_{BRANCH_NAME}.md`

## 最終出力形式
- 必ず以下の形式で出力を行ってください

### プラン策定完了の場合
status: SUCCESS
next: PUSH
details: "コミット完了。docs/review/{TIMESTAMP}_{BRANCH_NAME}.mdに詳細記録。"

