# REVIEW フェーズ

## 目的
実装内容のレビューを行う。

## 必要な入力ファイル
- `docs/implement/{TIMESTAMP}_{TITLE}.md` - 実装内容

## 注意事項
- 関連するコードは全て読むこと。
- 全ての処理においてultrathinkでしっかりと考えて作業を行うこと。

# ユーザの入力
#$ARGUMENTS


## タスクに含まれるべきTODO
1. ユーザの指示を理解する
2. 最新の `docs/implement/{TIMESTAMP}_{TITLE}.md` を読み込み、実装内容を確認
3. 既存のコードを全て読み、正しく理解する
4. 実装された内容を読み込み、内容を理解する
5. レビューを行い、修正は行わず `docs/review/{TIMESTAMP}_{BRANCH_NAME}.md` に出力する
6. プラン完成とファイル保存に関して`afplay /System/Library/Sounds/Funk.aiff`を実行しユーザに通知

## 出力ファイル
- `docs/review/{TIMESTAMP}_{BRANCH_NAME}.md`

## 最終出力形式
- 必ず以下の形式で出力を行ってください

### 正常に完了した場合
status: SUCCESS
next: COMMIT
details: "実装レビュー完了。docs/review/{TIMESTAMP}_{BRANCH_NAME}.mdに詳細記録。"

### 実装に重大なエラーやバグが存在した場合
status: ERROR
next: 
details: "実装に重大なエラーやバグが存在します。修正してください。{ERROR}"
