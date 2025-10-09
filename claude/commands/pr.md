# PR作成・更新コマンド

このコマンドは、現在のブランチのPull Requestを自動的に作成または更新します。
既存PRがある場合は説明を更新し、ない場合は新規作成します。

## Claudeへの指示

以下の手順を**必ず順番に**実行してください：

### ステップ1: 現在の状態を確認

並列実行で以下を確認：
- `git status` - 現在のブランチ名と変更状態を確認
- `git log origin/master..HEAD --oneline` - PRに含まれる全コミットを確認
- `git diff origin/master...HEAD` - masterブランチからの差分全体を確認

### ステップ2: 既存PRの確認

```bash
/opt/homebrew/bin/gh pr list --head <現在のブランチ名> --json number,url,title
```

- 注意: `gh`コマンドは**必ず**`/opt/homebrew/bin/gh`を使用すること（aliasを避けるため）
- 結果をパースして、PRの有無を判定

### ステップ3: PR説明文の作成

- **全てのコミット**（masterから分岐後の全コミット）を分析
- `.github/PULL_REQUEST_TEMPLATE.md`のテンプレートに従って説明を作成
- 以下のガイドラインに沿った内容にする
- 変更内容と影響範囲を明確に記載

### ステップ4: PRの作成または更新

**既存PRがある場合:**
```bash
/opt/homebrew/bin/gh pr edit <PR番号> --body "$(cat <<'EOF'
<作成したPR説明文>
EOF
)"
```

実行後、以下のメッセージを表示：
```
✅ 既存PR #<番号> を更新しました
📝 タイトル: <PRタイトル>
🔗 URL: <PR URL>
```

**既存PRがない場合:**

1. ブランチがpushされているか確認し、必要ならpush:
   ```bash
   git push -u origin <ブランチ名>
   ```

2. PRを作成:
   ```bash
   /opt/homebrew/bin/gh pr create --title "<タイトル>" --body "$(cat <<'EOF'
   <作成したPR説明文>
   EOF
   )"
   ```

3. 実行後、以下のメッセージを表示：
   ```
   ✅ 新規PR #<番号> を作成しました
   📝 タイトル: <PRタイトル>
   🔗 URL: <PR URL>
   ```

### 重要な注意事項

- PRタイトルは下記のガイドラインに従うこと
- PR説明は`.github/PULL_REQUEST_TEMPLATE.md`の形式に従うこと
- 何をしたか（新規作成 or 更新）を必ず明確に表示すること

---

このリポジトリのPull Requestを作成する際のガイドラインと制約事項です。

## PRタイトルの形式

以下のプレフィックスを使用してください：

- `feat:` - 新機能の追加
- `fix:` - バグ修正
- `update:` - 既存機能の更新・改善
- `refactor:` - リファクタリング
- `test:` - テストの追加・修正
- `docs:` - ドキュメントの変更
- `chore:` - ビルドプロセスや補助ツールの変更

- 影響のあるProjectを記載してください。(ex. [Bid], [Ad])

### 例
```
feat: implement video validation for S3 events
fix: debug log output for bid service
update: optimize UA candidate filtering logic
```

## PRボディの構成

以下の要素を含めてください：

### 必須項目

PR作成におけるTemplateは `conv-apps/.github/PULL_REQUEST_TEMPLATE.md` にあるので参照してください。


### 任意項目

- **スクリーンショット**: UI変更がある場合
- **パフォーマンス影響**: パフォーマンスに影響がある場合
- **破壊的変更**: 後方互換性がない変更の場合は明記
- **関連Issue**: 関連するIssueがあればリンク
- **関連PR**: 複数リポジトリを跨ぐ場合、他リポジトリのPRをリンク（例: `user-api: org/user-api#123`）

## コミットメッセージの規約

- コミットメッセージは明確で簡潔に
- 複数の独立した変更は別々のコミットに分ける
- PRマージ時のコミットメッセージにPR番号が自動付与される形式: `(#15352)`

## PR作成前のチェックリスト

以下を必ず確認してください：

- [ ] 関連するテストがすべて通る
- [ ] 新規コードに適切なテストを追加した
- [ ] コードレビューに必要な情報をPR説明に含めた
- [ ] CircleCIのビルドが成功する

## PRのステータス管理

1. **Draft / [WIP]**
   - 作業中でレビュー準備ができていない場合
   - Draftに設定、またはタイトルに `[WIP]` プレフィックスを追加

2. **Ready for Review**
   - すべてのチェックリストを完了
   - 1人以上のレビュアーをリクエスト

3. **Approved**
   - 最低1つの承認を取得
   - できるだけ早くマージしてリリース

## 制約事項

### 必須制約

- **テストの通過**: bid, ad, imp, rd などの関連プロジェクトのテストが通ること
- **レビュー**: 少なくとも1つの承認が必要
- **CircleCI**: CIが成功すること

### 推奨事項

- 大きな変更は小さなPRに分割
- レビュアーの負担を考慮（1PR = 400行以内を目安）
- 緊急の場合はSlackでレビュアーに通知
- [Github's Scheduled reminders](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-user-account/managing-your-membership-in-organizations/managing-your-scheduled-reminders) を設定

## 新規プロジェクト追加時の注意

新しいプロジェクトをリポジトリに追加する場合：

1. `.circleci/config-gen.rb` を更新
2. 以下のコマンドで設定ファイルを生成:
   ```sh
   ruby .circleci/config-gen.rb
   ```

## 参考リンク

- [README - Contributing](./README.md#contributing)
- [Pull Request Flow](./assets/pull-request-flow.svg)
