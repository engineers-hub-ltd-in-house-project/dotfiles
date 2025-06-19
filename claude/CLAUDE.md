# Personal Coding Standards for Claude Code
This file contains my personal coding preferences and standards that apply across all projects.

## 基本的なコーディング規約

### 命名規則
- 変数名は意味のある名前を使用する（例：`userData`, not `data`）
- 関数名は動詞で始める（例：`getUserData`, `validateInput`）
- bool値には`is`/`has`/`can`プレフィックス（例：`isValid`, `hasPermission`）
- 略語は避ける（例：`user`, not `usr`）

### フォーマット
- インデントは2スペース（TypeScript/JavaScript）、4スペース（Python/Rust）
- 1行の最大文字数は100文字
- 末尾のコンマを使用する
- オブジェクトリテラルでは適切な改行を行う

### 構造
- 関数は20行以内に収める
- ネストは3階層まで
- 早期リターン（ガード句）を使用する
- 関数の引数は5個まで（それ以上はオブジェクトにまとめる）

## SOLID原則

### 単一責任原則 (SRP)
- 1つのクラス/関数は1つの責任のみを持つ
- 変更の理由は1つのみであるべき

### 依存性逆転原則 (DIP)
- 抽象に依存し、具象に依存しない
- 依存性注入（DI）を使用する

## クリーンコード原則

### 関数
- 関数は1つのことだけを行う
- 関数名は何をするかを明確に示す
- 副作用を避ける
- 純粋関数を優先する

### エラーハンドリング
- 適切なエラーメッセージを提供する
- エラーは早期に検出し、適切に処理する
- カスタムエラークラスを定義する

## テスト

### テスト戦略
- テストファーストまたはTDDを実践
- テストは独立して実行可能
- テスト名は何をテストするかを明確に示す
- AAA（Arrange, Act, Assert）パターンを使用

## 言語別のベストプラクティス

### Go
```go
// 命名規則
- エクスポートされる名前は大文字で始める
- インターフェース名は"-er"で終わる（例：Reader, Writer）
- パッケージ名は小文字、単数形、短く
- getterにGetプレフィックスは不要（例：Name(), not GetName()）

// エラーハンドリング
if err != nil {
    return fmt.Errorf("failed to process: %w", err)
}

// 構造体の初期化
user := &User{
    Name:  name,
    Email: email,
}

// defer でリソースクリーンアップ
defer file.Close()

// ゴルーチンとチャネル
- context.Contextで適切にキャンセル処理
- チャネルのクローズは送信側で行う
- selectでタイムアウト処理を実装

// テスト
- テーブル駆動テストを使用
- t.Run()でサブテストを作成
- testifyなどのアサーションライブラリを活用
```

### Rust
```rust
// 所有権とライフタイム
- 必要な場合のみclone()を使用
- 借用を優先（&, &mut）
- ライフタイムは推論に任せ、必要時のみ明示

// エラーハンドリング
- unwrap()は避け、?演算子を使用
- カスタムエラー型にはthiserrorクレート
- Result<T, E>とOption<T>を適切に使い分け

// パターンマッチング
match result {
    Ok(value) => process(value),
    Err(e) => eprintln!("Error: {}", e),
}

// イディオム
- if letとmatchを適切に使い分け
- イテレータメソッドチェーンを活用
- derive属性を活用（Debug, Clone, PartialEq等）

// 非同期処理
- tokioまたはasync-stdを使用
- .await?でエラー伝播
```

### Python
```python
# PEP 8準拠
- インデント4スペース
- クラス名はPascalCase
- 関数名とメソッド名はsnake_case
- 定数は大文字のSNAKE_CASE

# 型ヒント
def process_user(user_id: int) -> Optional[User]:
    pass

# データクラス
@dataclass
class User:
    name: str
    email: str
    age: int = 0

# コンテキストマネージャー
with open('file.txt', 'r') as f:
    content = f.read()

# 例外処理
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}")
    raise

# イディオム
- f-stringsを使用
- List/Dict comprehensionを適切に使用
- ジェネレータで大量データを効率的に処理
- pathlib.Pathでファイルパス操作
```

### Ruby
```ruby
# 命名規則
- メソッド名と変数名はsnake_case
- クラス名とモジュール名はPascalCase
- 定数は大文字のSNAKE_CASE
- 述語メソッドは?で終わる（例：empty?）
- 破壊的メソッドは!で終わる（例：sort!）

# イディオム
# ガード句
return if condition

# Safe navigation operator
user&.name

# ブロック
users.map { |user| user.name }
# または
users.map(&:name)

# メソッド定義
def process_data(data, options = {})
  # キーワード引数を推奨
end

# 例外処理
begin
  risky_operation
rescue StandardError => e
  Rails.logger.error(e.message)
  raise
ensure
  cleanup
end

# モジュールとMixin
module Validatable
  extend ActiveSupport::Concern
  
  included do
    # クラスマクロ
  end
end
```

### TypeScript
```typescript
// 型定義
- interfaceを優先（型エイリアスは必要時のみ）
- 明示的な型注釈（推論が不明確な場合）
- strictモードを有効化

// ユーティリティ型
type Readonly<T>
type Partial<T>
type Pick<T, K>
type Omit<T, K>

// 非同期処理
const fetchUser = async (id: string): Promise<User> => {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch user: ${error.message}`);
  }
};

// Null安全
- Optional chaining: user?.address?.street
- Nullish coalescing: value ?? defaultValue

// イミュータブル操作
const newArray = [...oldArray, newItem];
const newObject = { ...oldObject, key: value };

// 型ガード
function isUser(obj: any): obj is User {
  return obj && typeof obj.name === 'string';
}
```

### フレームワーク別ベストプラクティス

### React
```jsx
// コンポーネント設計
- 関数コンポーネントとHooksを使用
- 単一責任原則を守る
- Props型定義を明確に

// Hooks
const [state, setState] = useState<T>(initialValue);
const memoizedValue = useMemo(() => computeExpensive(a, b), [a, b]);
const stableCallback = useCallback(() => {}, [deps]);

// パフォーマンス
- React.memoで不要な再レンダリングを防ぐ
- key属性を適切に設定
- 大量リストは仮想スクロール

// 状態管理
- ローカル状態はuseState
- グローバル状態はContext APIまたは状態管理ライブラリ
- フォームはreact-hook-formなどを活用

// エラーバウンダリ
class ErrorBoundary extends Component {
  componentDidCatch(error, errorInfo) {
    logErrorToService(error, errorInfo);
  }
}
```

### Vue.js
```vue
<!-- Composition API推奨 -->
<script setup lang="ts">
import { ref, computed, watch, onMounted } from 'vue'

// リアクティブな状態
const count = ref(0)
const doubled = computed(() => count.value * 2)

// ライフサイクル
onMounted(() => {
  console.log('Component mounted')
})

// ウォッチャー
watch(count, (newVal, oldVal) => {
  console.log(`Count changed: ${oldVal} -> ${newVal}`)
})
</script>

<!-- テンプレート -->
<template>
  <div>
    <p>{{ count }}</p>
    <button @click="count++">Increment</button>
  </div>
</template>

<!-- スタイル -->
<style scoped>
/* スコープ付きスタイル */
</style>

<!-- ベストプラクティス -->
- v-for には必ず :key を指定
- v-if と v-for を同じ要素で使わない
- コンポーネントは PascalCase
- props の型定義を明確に
- emit の型定義も忘れずに
```

### Svelte
```svelte
<script lang="ts">
  // Props
  export let name: string;
  export let count = 0; // デフォルト値付き
  
  // リアクティブな宣言
  $: doubled = count * 2;
  $: if (count > 10) {
    console.log('Count is too high!');
  }
  
  // ストア
  import { writable } from 'svelte/store';
  const user = writable({ name: 'John' });
  
  // イベントハンドリング
  function handleClick() {
    count += 1;
  }
  
  // ライフサイクル
  import { onMount, onDestroy } from 'svelte';
  onMount(() => {
    const interval = setInterval(() => {}, 1000);
    return () => clearInterval(interval);
  });
</script>

<main>
  <h1>Hello {name}!</h1>
  <button on:click={handleClick}>
    Clicked {count} {count === 1 ? 'time' : 'times'}
  </button>
  <p>{doubled}</p>
</main>

<style>
  /* コンポーネントスコープのスタイル */
  main {
    padding: 1em;
  }
</style>

<!-- ベストプラクティス -->
- リアクティブ宣言を活用
- ストアで状態管理
- スロットでコンポジション
- アクションで再利用可能なDOM操作
```

### PHP
```php
<?php
// PSR-12 コーディング規約準拠

// 名前空間とuse宣言
namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\DB;

// 型宣言
declare(strict_types=1);

class UserService
{
    // プロパティの型宣言
    private UserRepository $repository;
    
    // コンストラクタインジェクション
    public function __construct(UserRepository $repository)
    {
        $this->repository = $repository;
    }
    
    // 戻り値の型宣言
    public function findUser(int $id): ?User
    {
        return $this->repository->find($id);
    }
    
    // PHP 8の新機能
    public function updateUser(
        int $id,
        ?string $name = null,
        ?string $email = null,
    ): User {
        // Null合体演算子
        $user = $this->findUser($id) ?? throw new UserNotFoundException();
        
        // Null安全演算子
        $user->name = $name ?? $user->name;
        $user->email = $email ?? $user->email;
        
        return $user;
    }
}

// エラーハンドリング
try {
    DB::transaction(function () use ($data) {
        // トランザクション処理
    });
} catch (\Exception $e) {
    Log::error('Transaction failed', ['error' => $e->getMessage()]);
    throw $e;
}
```

### Laravel
```php
// Eloquentモデル
class User extends Model
{
    // マスアサインメント保護
    protected $fillable = ['name', 'email'];
    
    // 属性キャスト
    protected $casts = [
        'email_verified_at' => 'datetime',
        'is_admin' => 'boolean',
    ];
    
    // アクセサ/ミューテタ (Laravel 9+)
    protected function name(): Attribute
    {
        return Attribute::make(
            get: fn ($value) => ucfirst($value),
            set: fn ($value) => strtolower($value),
        );
    }
    
    // リレーション
    public function posts(): HasMany
    {
        return $this->hasMany(Post::class);
    }
    
    // スコープ
    public function scopeActive(Builder $query): Builder
    {
        return $query->where('active', true);
    }
}

// コントローラー
class UserController extends Controller
{
    // 依存性注入
    public function __construct(
        private UserService $userService
    ) {}
    
    // RESTful アクション
    public function index(Request $request): JsonResponse
    {
        $users = User::active()
            ->with('posts') // N+1問題を防ぐ
            ->paginate(20);
            
        return response()->json($users);
    }
    
    // フォームリクエスト
    public function store(StoreUserRequest $request): JsonResponse
    {
        $user = $this->userService->create($request->validated());
        
        return response()->json($user, 201);
    }
}

// バリデーション
class StoreUserRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', 'unique:users'],
            'password' => ['required', 'min:8', 'confirmed'],
        ];
    }
}

// ミドルウェア
class CheckAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        if (!$request->user()?->is_admin) {
            abort(403);
        }
        
        return $next($request);
    }
}

// ベストプラクティス
- Eloquent ORMのN+1問題に注意（eager loading使用）
- キューで重い処理を非同期化
- キャッシュを適切に使用
- サービスプロバイダーでDI設定
- アーティザンコマンドでタスク自動化
- テストはFeature/Unitで分離
```

## Git コミットメッセージ

### 形式
```
<type>: <subject>

<body>

<footer>
```

### タイプ
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更
- `refactor`: バグ修正や機能追加を伴わないコード変更
- `test`: テストの追加・修正
- `chore`: ビルドプロセスやツールの変更

### 日本語プロジェクトの場合
- コミットメッセージは日本語でも可
- 例: `feat: ユーザー認証機能を追加`

## よく使うコマンド

### Rust (cargo)
```bash
cargo check          # コンパイルチェック
cargo test           # テスト実行
cargo fmt            # フォーマット
cargo clippy         # リンター
cargo make run       # プロジェクト実行（cargo-make使用時）
```

### Node.js
```bash
npm test             # テスト実行
npm run lint         # リンター
npm run format       # フォーマット
npm run dev          # 開発サーバー起動
```

### Python
```bash
pytest               # テスト実行
black .              # フォーマット
flake8              # リンター
mypy .              # 型チェック
```

## コードレビュー時の観点
- ビジネス要件を満たしているか
- テストは十分か
- パフォーマンスに問題はないか
- セキュリティ上の問題はないか
- 既存のパターンに従っているか

## 個人的な好み
- コメントよりもコード自体で説明することを優先
- マジックナンバーは定数として定義
- 不要な複雑さを避ける（YAGNI - You Aren't Gonna Need It）
- 読みやすさを最優先（Readability counts）
- 早すぎる最適化を避ける

## セキュリティ
- 入力は常に検証する
- 機密情報をログに出力しない
- SQLインジェクション対策を実装
- 最小権限の原則を適用

## デバッグとトラブルシューティング

### 一般的なアプローチ
- エラーメッセージを最後まで読む
- 最小限の再現コードを作成
- ログを適切なレベルで出力
- バイナリサーチで問題箇所を特定

### 言語別デバッグツール
```bash
# Rust
RUST_LOG=debug cargo run  # ログレベル設定
RUST_BACKTRACE=1          # スタックトレース表示

# Node.js
node --inspect            # Chrome DevToolsでデバッグ
console.log(util.inspect(obj, { depth: null }))  # 深いオブジェクト表示

# Python
import pdb; pdb.set_trace()  # ブレークポイント
python -m pdb script.py      # デバッガー起動
```

## パフォーマンス最適化

### 計測優先
- 推測せず、プロファイリングツールで計測
- ボトルネックを特定してから最適化
- ビッグO記法を意識したアルゴリズム選択

### 言語別プロファイリング
```bash
# Rust
cargo flamegraph         # フレームグラフ生成
cargo bench             # ベンチマークテスト

# Node.js
node --prof app.js      # V8プロファイラー
clinic doctor           # パフォーマンス診断

# Python
python -m cProfile script.py  # プロファイリング
```

## ドキュメント作成

### API ドキュメント
- OpenAPI/Swagger仕様書を維持
- 各エンドポイントに例を含める
- エラーレスポンスも文書化

### README 構成
1. プロジェクト概要
2. セットアップ手順
3. 使用方法
4. アーキテクチャ概要
5. 貢献方法
6. ライセンス

## CI/CD 考慮事項

### テスト
- ユニットテスト: 高速、独立
- 統合テスト: 実際の依存関係でテスト
- E2Eテスト: ユーザー視点の動作確認

### デプロイメント
- Blue-Green デプロイメント
- カナリアリリース
- フィーチャーフラグの活用

---
Note: これは個人的な好みです。プロジェクト固有のルールがある場合はそちらを優先してください。