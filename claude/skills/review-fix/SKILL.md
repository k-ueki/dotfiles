---
name: review-fix
description: Collect `// REVIEW:` (fix requests) and `// REVIEW?:` (questions) comments left in the codebase, implement fixes for REVIEW: markers and answer REVIEW?: questions in-chat. Use when the user says /review-fix or asks to "apply the review comments", "process the REVIEW comments", or similar.
---

# review-fix

The user has been reviewing AI-generated (or any) code and left inline markers as a punch list. Two marker types exist:

- **`REVIEW:`** — a fix request. Implement the change and delete the marker.
- **`REVIEW?:`** — a question. Answer in-chat only. Do NOT edit the code and do NOT delete the marker.

## When to invoke

- User invokes `/review-fix` slash command.
- User asks to "apply the review comments", "process the REVIEW comments", "対応してください" referring to REVIEW markers, or similar.

## Marker format

Reviewers use their language's comment syntax, prefixed with either `REVIEW:` (fix) or `REVIEW?:` (question). Examples:

```typescript
// REVIEW: null チェックが漏れている。null なら空配列を返してほしい
function foo(items) { ... }
```

```python
# REVIEW: マジックナンバー 42 を定数化してほしい
if count > 42: ...
```

```lua
-- REVIEW: ここでのエラーハンドリングを追加して
```

```scala
// REVIEW: このパターンマッチ、default ケースが exhaustive じゃない
```

Question example (answer only, do not edit code):

```typescript
// REVIEW?: このアルゴリズム、O(n²) になってない?
function search(items) { ... }
```

Any single-line comment prefix followed by `REVIEW:` or `REVIEW?:` counts. Do NOT match `TODO:`, `FIXME:`, `XXX:` — those are for humans, not this skill.

## Execution flow

Follow this sequence strictly:

### 1. Collect

Use Grep (via the Grep tool, not shell `grep`) to find both markers. Search separately so you can classify each hit:

- Pattern for fixes: `REVIEW:` (note: `REVIEW?:` also contains `REVIEW:` as a substring after the `?`, so use a stricter pattern like `REVIEW:[^?]` or grep for the two markers independently with `REVIEW\?:` and `REVIEW:` and dedupe)
- Pattern for questions: `REVIEW\?:`
- Return with `-n` (line numbers) and enough context to understand the target code (`-A 3`).
- Respect gitignore (Grep's default).

Classify each hit into **fix** (`REVIEW:`) or **question** (`REVIEW?:`).

If **zero** total hits, report "REVIEW / REVIEW? コメントは見つかりませんでした" and stop.

### 2. Present the punch list

Before making any changes, show the user a numbered list, marking fix vs. question:

```
Found N items (X fixes, Y questions):

Fixes:
1. src/foo.ts:42 [FIX]
   REVIEW: null チェックが漏れている。null なら空配列を返してほしい

2. src/bar.ts:15 [FIX]
   REVIEW: マジックナンバー 42 を定数化してほしい

Questions:
3. src/baz.ts:80 [Q]
   REVIEW?: このアルゴリズム、O(n²) になってない?
...
```

Then ask: **"上から順に対応します（質問は回答のみ、コードは触りません）。よろしいですか？ 特定のもののみ対応したい場合は番号を指定してください。"**

Wait for user confirmation. Reviewers sometimes leave WIP notes they don't want acted on yet.

### 3. Process each item

For each confirmed item, dispatch by type:

#### 3a. Fix items (`REVIEW:`)

1. **Read** the file and understand the surrounding code (not just the flagged line).
2. **Decide** how to satisfy the request. If the intent is ambiguous, STOP and ask the user before editing. Do not guess when the request is non-trivial.
3. **Edit** the code following the project's existing conventions.
4. **Leave the REVIEW: marker in place for now.** It will be cleaned up in the batch confirmation step (see section 4). This lets the user cross-reference the marker with the diff before the punch list disappears.
5. **Do not** add a self-congratulatory comment like `// fixed REVIEW`. The git diff is the record.

#### 3b. Question items (`REVIEW?:`)

1. **Read** the file and understand the surrounding code so the answer is grounded.
2. **Answer in the chat only.** Present the answer under a clear heading like:

   ```
   ### Q: src/baz.ts:80
   > REVIEW?: このアルゴリズム、O(n²) になってない?

   A: はい、内側の filter が毎回 O(n) 走るので全体で O(n²) です。
   n が数百規模ならこのままで問題ないですが、数千超えるなら
   Map で index を作る書き換えで O(n) に落とせます。
   ```

3. **Do NOT edit any code** to satisfy the question.
4. If the question implies an action the user might want ("should we fix this?"), end your answer with a **suggestion of next steps** (e.g. "対応するなら `REVIEW?:` を `REVIEW:` に書き換えて再度 `/review-fix` を実行してください"). Do not act on it unprompted.
5. **Leave the REVIEW?: marker in place** — cleanup happens in section 4 with user approval.

### 4. Cleanup (batch confirmation)

After all fixes are applied and all questions are answered, present a single deletion checklist covering every marker that was processed:

```
以下の REVIEW / REVIEW? コメントを削除します。よろしいですか?

Fixes (対応済み):
- src/foo.ts:42  // REVIEW: null チェックが漏れている…
- src/bar.ts:15  // REVIEW: マジックナンバー 42 を定数化して…

Questions (回答済み):
- src/baz.ts:80  // REVIEW?: このアルゴリズム、O(n²) になってない?

削除しない項目があれば番号または file:line を指定してください。
「はい」/「全部OK」で全削除、「なし」でスキップ。
```

Rules for this step:

- **Wait for explicit approval.** Do not delete on silence.
- If the user says yes to all, delete every listed marker in a single pass.
- If the user names exclusions ("baz.ts:80 は残して"), delete the rest and keep the named ones untouched.
- If the user says no / skip, keep every marker.
- **Never delete a marker that was skipped in step 2** (user chose not to process it) or that was left unresolved due to clarification-in-progress. The user might still be thinking.

### 5. Report

Finally, summarize:

- Fixes: how many resolved, which files were modified
- Questions: how many answered
- Markers deleted vs. retained
- Any items skipped (per user request or needing clarification)

Do NOT commit or run tests unless the user explicitly asks.

## Guardrails

- **Ambiguity → ask, don't guess.** Reviewer comments are often terse. If "null チェック追加して" doesn't specify what to return in the null case, ask.
- **Don't scope-creep.** Fix what the REVIEW says, not adjacent code that "looks bad". Trust the reviewer picked their fights.
- **Preserve the comment's language.** Japanese in, Japanese out. English in, English out.
- **One comment, one purpose.** If a single REVIEW asks for two unrelated things, address both.
- **If a REVIEW references a spec / issue / URL,** fetch and read it before implementing. Don't fake understanding.
- **Never convert a question into a silent fix.** `REVIEW?:` = answer only. If the reviewer wanted a fix they'd use `REVIEW:`.

## What this skill does NOT do

- Adding new REVIEW comments (that's the reviewer's job in their editor).
- Running tests, linters, or committing (user handles verification).
- Escalating to other tools like external code review services.

## Failure modes to avoid

- **Silent skip.** If you cannot address a REVIEW (unclear intent, file gone, etc.), say so explicitly. Do not remove the marker without fixing.
- **Marker collision.** If a REVIEW comment happens to be inside a string literal or another comment (e.g. a documentation block explaining this skill), verify context before treating it as a live marker. Ask the user if uncertain.
- **Cross-file dependencies.** If fixing a REVIEW in file A requires changes in file B (not marked), do both changes and mention it in the report.
