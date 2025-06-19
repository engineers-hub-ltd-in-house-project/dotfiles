# Personal Coding Standards for Claude Code
This file contains my personal coding preferences and standards that apply across all projects.

## 基本的なコーディング規約

### 命名規則
- 変数名は意味のある名前を使用する（例：`userData`, not `data`）
- 関数名は動詞で始める（例：`getUserData`, `validateInput`）
- クラス名はPascalCase（例：`UserService`, `OrderManager`）
- 定数は大文字のSNAKE_CASE（例：`MAX_RETRY_COUNT`）
- ファイル名はkebab-case（例：`user-service.ts`）
- bool値には`is`/`has`/`can`プレフィックス（例：`isValid`, `hasPermission`）
- 略語は避ける（例：`user`, not `usr`）

### フォーマット
- インデントは2スペース（TypeScript/JavaScript）、4スペース（Python/Rust）
- 1行の最大文字数は100文字
- 末尾のコンマを使用する
- セミコロンを必須とする（JavaScript/TypeScript）
- クォートはシングルクォートを優先（JavaScript/TypeScript）
- オブジェクトリテラルでは適切な改行を行う

### 構造
- 関数は20行以内に収める
- クラスは200行以内に収める
- ネストは3階層まで
- 循環的複雑度は10以下
- 早期リターン（ガード句）を使用する
- 関数の引数は5個まで（それ以上はオブジェクトにまとめる）

## SOLID原則

### 単一責任原則 (SRP)
- 1つのクラス/関数は1つの責任のみを持つ
- 変更の理由は1つのみであるべき
- 高凝集・低結合を維持する
- 責任が複数ある場合は分割を検討する

### 開放閉鎖原則 (OCP)
- 拡張に対して開いており、変更に対して閉じている
- 抽象化とポリモーフィズムを活用する
- Strategy パターンや Factory パターンを使用する
- 既存コードを変更せずに新機能を追加できる設計にする

### リスコフ置換原則 (LSP)
- 派生クラスは基底クラスの代替として使用可能であるべき
- 基底クラスの契約を派生クラスで破らない
- オーバーライド時に事前条件を強化しない
- オーバーライド時に事後条件を弱化しない

### インターフェース分離原則 (ISP)
- クライアントは使用しないメソッドに依存を強制されない
- 大きなインターフェースは小さく分割する
- ロールベースのインターフェース設計
- Fat Interfaceを避ける

### 依存性逆転原則 (DIP)
- 上位レベルモジュールは下位レベルモジュールに依存しない
- 抽象に依存し、具象に依存しない
- 依存性注入（DI）を使用する
- IoC（制御の逆転）を実践する

## クリーンコード原則

### 意味のあるコード
- コードは意図を明確に表現する
- コメントよりもコード自体で説明する
- マジックナンバーは定数として定義する
- ガード句を使用して早期リターンする
- ネガティブ条件を避ける

### 関数
- 関数は1つのことだけを行う
- 関数名は何をするかを明確に示す
- 引数は少なく保つ（理想は0-2個）
- 副作用を避ける
- 純粋関数を優先する
- フラグ引数を避ける

### エラーハンドリング
- 例外を使用してエラーを処理する
- nullを返すより例外を投げる
- エラーコードよりも例外を使用する
- try-catch-finallyを適切に使用する
- カスタム例外クラスを定義する
- 適切なエラーメッセージを提供する
- エラーは早期に検出し、適切に処理する

## テスト

### テスト戦略
- テストピラミッドを維持（単体テスト > 統合テスト > E2Eテスト）
- コードカバレッジは80%以上を目標
- テストファーストまたはTDDを実践
- テストは独立して実行可能
- テストは決定論的である
- テスト名は何をテストするかを明確に示す
- AAA（Arrange, Act, Assert）パターンを使用

### 単体テスト
- 1つのテストは1つのことをテストする
- モックとスタブを適切に使用
- 境界値テストを実装
- 例外ケースもテストする

### 統合テスト
- 外部システムとの連携をテスト
- データベースアクセスをテスト
- APIエンドポイントをテスト
- テストデータのセットアップとクリーンアップ

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
- `perf`: パフォーマンス改善
- `test`: テストの追加・修正
- `build`: ビルドシステムや外部依存関係の変更
- `ci`: CI設定ファイルやスクリプトの変更
- `chore`: その他の変更（ビルドプロセスやツールの変更など）
- `revert`: 以前のコミットの取り消し

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
ruff check .        # 高速リンター（flake8代替）
```

### Ruby
```bash
rspec               # テスト実行
rubocop             # リンター＆フォーマッター
rubocop -a          # 自動修正
bundle exec rails test  # Railsテスト
```

### Go
```bash
go test ./...       # テスト実行
go fmt ./...        # フォーマット
go vet ./...        # 静的解析
golangci-lint run   # 包括的なリンター
```

## アーキテクチャルール

### レイヤードアーキテクチャ
- プレゼンテーション層はビジネス層のみに依存
- ビジネス層はデータアクセス層のみに依存
- 下位層は上位層に依存しない
- 層をまたいだ直接アクセスを禁止

### ヘキサゴナルアーキテクチャ
- ドメインは外部依存を持たない
- ポートとアダプターパターンを使用
- インフラストラクチャはドメインに依存
- ドメインサービスは純粋なビジネスロジック

### マイクロサービス
- サービス間の通信はAPIまたはメッセージング
- データベースは各サービスで独立
- 共有ライブラリの使用を最小限に
- サービス境界はビジネス機能に基づく

## ドメイン駆動設計 (DDD)

### 戦略的設計
- ユビキタス言語を使用する
- 境界づけられたコンテキストを明確にする
- コンテキストマップを維持する
- ドメインエキスパートと協働する

### 戦術的設計
- エンティティは一意な識別子を持つ
- 値オブジェクトは不変である
- 集約は一貫性境界を定義する
- 集約ルートを通じてのみアクセス
- ドメインサービスはステートレス
- リポジトリは集約の永続化を担当
- ファクトリは複雑なオブジェクト生成を担当

### ドメインイベント
- 重要なビジネスイベントをドメインイベントとして表現
- イベントは過去形で命名
- イベントハンドラーは副作用を処理
- イベントソーシングを検討

## コードレビュー時の観点
- ビジネス要件を満たしているか
- 設計原則に従っているか
- テストカバレッジは十分か
- パフォーマンスに問題はないか
- セキュリティ上の問題はないか
- 既存のパターンに従っているか
- ドキュメントは更新されているか

## コードレビュープロセス
- 小さな変更に分割する
- 建設的なフィードバックを提供
- コードの動機を説明する
- 自動チェックを活用
- 必要に応じてペアプログラミング

## 個人的な好み
- コメントよりもコード自体で説明することを優先
- マジックナンバーは定数として定義
- 不要な複雑さを避ける（YAGNI - You Aren't Gonna Need It）
- 読みやすさを最優先（Readability counts）
- 早すぎる最適化を避ける

## セキュリティ

### 入力検証
- すべての入力を検証する
- ホワイトリスト方式を使用する
- SQLインジェクション対策を実装
- XSS対策を実装
- CSRF対策を実装

### 認証・認可
- パスワードはハッシュ化して保存
- セッション管理を適切に実装
- JWT使用時は適切な検証を実装
- 最小権限の原則を適用
- 多要素認証を推奨

### データ保護
- 機密データは暗号化する
- 機密情報をログに出力しない
- HTTPSを使用する
- 適切なCORSポリシーを設定
- セキュリティヘッダーを設定

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

# Go
dlv debug main.go        # Delveデバッガー
```

## パフォーマンス最適化

### 計測優先
- 推測せず、プロファイリングツールで計測
- ボトルネックを特定してから最適化
- ビッグO記法を意識したアルゴリズム選択

### 最適化技術
- N+1クエリ問題を避ける
- 適切なインデックスを作成
- キャッシュを効果的に使用
- 遅延ローディングを適用
- 不要なデータの取得を避ける

### スケーラビリティ
- ステートレスな設計を心がける
- 水平スケーリングを考慮
- 非同期処理を活用
- リソースプールを使用
- 適切な負荷分散を実装

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
py-spy record -o profile.svg -- python script.py  # フレームグラフ

# Go
go test -bench=. -cpuprofile=cpu.prof
go tool pprof cpu.prof
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

## フロントエンド固有ルール

### コンポーネント設計
- コンポーネントは単一責任を持つ
- Propsは読み取り専用
- 状態管理は適切なレベルで行う
- 副作用はライフサイクルメソッドまたはHookで管理
- キーを適切に設定する

### パフォーマンス
- 不要な再レンダリングを避ける
- 画像は適切に最適化する
- 遅延ローディングを実装
- バンドルサイズを最小化
- CDNを活用する

### アクセシビリティ
- セマンティックHTMLを使用
- 適切なARIAラベルを設定
- キーボードナビゲーションを実装
- 色だけに依存しない情報提供
- 適切なコントラスト比を維持

## バックエンド固有ルール

### API設計
- RESTful API設計原則に従う
- 適切なHTTPメソッドを使用
- 適切なHTTPステータスコードを返す
- 一貫したレスポンス形式を使用
- バージョニング戦略を実装
- 適切な認証・認可を実装

### データベース
- 正規化を適切に行う
- 適切な外部キー制約を設定
- トランザクションを適切に使用
- データベースマイグレーションを管理
- インデックスを適切に設計

### 非同期処理
- 長時間処理は非同期で実行
- 適切なタイムアウトを設定
- エラー処理とリトライ機能を実装
- キューイングシステムを使用
- デッドレターキューを実装

## ログ・監視ルール

### ログ
- 構造化ログを使用
- 適切なログレベルを設定
- 機密情報をログに出力しない
- 相関IDを使用してトレース
- メトリクスを適切に記録

### 監視
- ヘルスチェックエンドポイントを実装
- メトリクスを収集
- アラートを適切に設定
- SLI/SLOを定義
- 障害時の自動復旧を実装

## エラーハンドリングルール

### 例外処理
- 具体的な例外クラスを使用
- 例外メッセージは詳細で有用
- リソースのクリーンアップを確実に行う
- 例外チェーンを維持
- 回復可能な例外と不可能な例外を区別

### 障害対応
- サーキットブレーカーパターンを実装
- リトライ機能を実装（指数バックオフ）
- タイムアウト処理を実装
- グレースフル・デグラデーションを実装
- 障害の分離を行う

## デプロイメント・DevOpsルール

### CI/CD
- 自動テストをパイプラインに組み込む
- コード品質チェックを自動化
- セキュリティスキャンを実装
- 自動デプロイを実装
- ロールバック機能を実装

### インフラストラクチャ
- Infrastructure as Codeを実践
- 設定管理を自動化
- 環境の一貫性を保つ
- スケーリング戦略を実装
- 災害復旧計画を策定

---
Note: これは個人的な好みです。プロジェクト固有のルールがある場合はそちらを優先してください。

# 重要な指示事項
- Do what has been asked; nothing more, nothing less.
- NEVER create files unless they're absolutely necessary for achieving your goal.
- ALWAYS prefer editing an existing file to creating a new one.
- NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.