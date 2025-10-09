# TEST フェーズ

# ユーザの入力
#$ARGUMENTS

## 目的
追加・変更されたコードの **エンドポイント機能** をDocker環境で実行検証する。

## テスト実行方針
- **Docker環境での実行を必須**: 全てのテストはDockerコンテナ内で実行する
- **環境の一貫性**: 本番環境との差異を最小限に抑える
- **再現性の確保**: 環境依存の問題を排除する

## 必要な入力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/plan/{TIMESTAMP}_{TITLE}.md` - テスト要件の確認
- `~/.claude/docs/{REPOSITORY_NAME}/implement/{TIMESTAMP}_{TITLE}.md` - 実装内容の詳細
- 実装されたコード（現在のブランチ）

## テスト種別
- **エンドポイントテスト（必須）**
  - Docker Compose環境での実行
  - FastAPI: `TestClient` / `httpx`
  - 各エンドポイントの status_code == 200
  - レスポンス JSON が期待スキーマと一致
- **統合テスト（任意）**
  - Dockerコンテナ内でのデータベース連携テスト
  - Dockerコンテナ内での外部API連携テスト
- **E2Eテスト（任意）**
  - Docker環境でのPlaywright を使用したブラウザテスト


## タスクに含まれるべきTODO
1. ユーザの指示を理解し、テスト開始をコンソールで通知
2. 最新の `~/.claude/docs/{REPOSITORY_NAME}/plan/{TIMESTAMP}_{TITLE}.md` からテスト要件を確認
3. 最新の `~/.claude/docs/{REPOSITORY_NAME}/implement/{TIMESTAMP}_{TITLE}.md` から実装内容を確認
4. Docker Compose環境の構築・起動をユーザに通知
5. 追加・変更されたエンドポイントのテストケースを作成
6. Docker環境内でエンドポイントテストを実行
7. 統合・E2EテストをDocker環境内で必要に応じて実行
8. 各種テストの実行状況をユーザにリアルタイム通知
9. 失敗したテストがあれば詳細をユーザに報告
10. テスト結果を総合評価し文書化
11. Docker環境の停止・クリーンアップをユーザに通知
12. `~/.claude/docs/{REPOSITORY_NAME}/test/{TIMESTAMP}_{TITLE}.md`でテスト結果を保存
13. テスト完了とファイル保存をユーザに通知
14. 次フェーズへの移行判定をコンソール出力


## 出力ファイル
- `~/.claude/docs/{REPOSITORY_NAME}/test/{TIMESTAMP}_{TITLE}.md`

## 最終出力形式
- 必ず以下の三つの形式で出力を行ってください

### テスト成功の場合
status: SUCCESS
next: DONE
details: "全テスト通過。~/.claude/dosc/{REPOSITORY_NAME}/test/{TIMESTAMP}_{TITLE}.mdに詳細記録。"

### テスト失敗・修正が必要な場合
status: FAILURE
next: IMPLEMENT
details: "失敗: /users GET で 500 エラー。詳細は~/.claude/docs/{REPOSITORY_NAME}/test/{TIMESTAMP}_{TITLE}.mdを確認。修正が必要。"

### 根本的な問題が発覚した場合
status: CRITICAL_FAILURE
next: INVESTIGATE
details: "重大な問題を発見。~/.claude/docs/{REPOSITORY_NAME}/test/{TIMESTAMP}_{TITLE}.md。根本原因の再調査が必要。"
