# 準備

まず同じ階層にこのような json ファイルを作っておく。
今回名前は `test.json` とした

```
{
  "message": null,
  "results": [
    {
      "address1": "香川県",
      "address2": "高松市",
      "address3": "",
      "kana1": "ｶｶﾞﾜｹﾝ",
      "kana2": "ﾀｶﾏﾂｼ",
      "kana3": "",
      "prefcode": "37",
      "zipcode": "7600000"
    },
    {
      "address1": "東京都",
      "address2": "足立区",
      "address3": "",
      "kana1": "ﾄｳｷｮｳﾄ",
      "kana2": "ｱﾀﾞﾁｸ",
      "kana3": "",
      "prefcode": "13",
      "zipcode": "1200000"
    },
    {
      "address1": "千葉県",
      "address2": "千葉市中央区",
      "address3": "",
      "kana1": "ﾁﾊﾞｹﾝ",
      "kana2": "ﾁﾊﾞｼﾁｭｳｵｳｸ",
      "kana3": "",
      "prefcode": "12",
      "zipcode": "2600000"
    }
  ],
  "status": 200
}
```

### 確認

```
$ cat test.json
{
  "message": null,
  "results": [
    {
      "address1": "香川県",
      "address2": "高松市",
      "address3": "",
      "kana1": "ｶｶﾞﾜｹﾝ",
      "kana2": "ﾀｶﾏﾂｼ",
      "kana3": "",
      "prefcode": "37",
      "zipcode": "7600000"
    },
    {
      "address1": "東京都",
      "address2": "足立区",
      "address3": "",
      "kana1": "ﾄｳｷｮｳﾄ",
      "kana2": "ｱﾀﾞﾁｸ",
      "kana3": "",
      "prefcode": "13",
      "zipcode": "1200000"
    },
    {
      "address1": "千葉県",
      "address2": "千葉市中央区",
      "address3": "",
      "kana1": "ﾁﾊﾞｹﾝ",
      "kana2": "ﾁﾊﾞｼﾁｭｳｵｳｸ",
      "kana3": "",
      "prefcode": "12",
      "zipcode": "2600000"
    }
  ],
  "status": 200
}
```

# 必要なデータだけ取得

### 特定の key に絞る

```
$ cat test.json | jq '.results'
[
  {
    "address1": "香川県",
    "address2": "高松市",
    "address3": "",
    "kana1": "ｶｶﾞﾜｹﾝ",
    "kana2": "ﾀｶﾏﾂｼ",
    "kana3": "",
    "prefcode": "37",
    "zipcode": "7600000"
  },
  {
    "address1": "東京都",
    "address2": "足立区",
    "address3": "",
    "kana1": "ﾄｳｷｮｳﾄ",
    "kana2": "ｱﾀﾞﾁｸ",
    "kana3": "",
    "prefcode": "13",
    "zipcode": "1200000"
  },
  {
    "address1": "千葉県",
    "address2": "千葉市中央区",
    "address3": "",
    "kana1": "ﾁﾊﾞｹﾝ",
    "kana2": "ﾁﾊﾞｼﾁｭｳｵｳｸ",
    "kana3": "",
    "prefcode": "12",
    "zipcode": "2600000"
  }
]
```

### key だけ取得

```
$ cat test.json | jq '.|keys'
[
  "message",
  "results",
  "status"
]
```

### value を取得

`.results[]` とすると、要素ごとにパイプに渡すことになる。
`address1,address2,address3` とフィルタに渡していって、指定された `.address1` の value を出力してくれている

```
$ cat test.json | jq '.results[].address1'
"香川県"
"東京都"
"千葉県"

# こっちの書き方のほうが一般的だとかなんとか
$ cat test.json | jq '.results[] | .address1'
"香川県"
"東京都"
"千葉県"

# 配列の何番目かを指定
$ cat test.json | jq '.results[0].address1'
"香川県"

# 複数取得したい場合は、カンマ区切りにすればOK
$ cat test.json | jq '.results[] | .address1, .address2'
"香川県"
"高松市"
"東京都"
"足立区"
"千葉県"
"千葉市中央区"

# [] でくくるといい感じになる
$ cat test.json | jq '.results[] | [.address1, .address2]'
[
  "香川県",
  "高松市"
]
[
  "東京都",
  "足立区"
]
[
  "千葉県",
  "千葉市中央区"
]

# csv 出力
$ cat test.json | jq -r '.results[] | [.address1, .address2] | @csv'
"香川県","高松市"
"東京都","足立区"
"千葉県","千葉市中央区"
```

ちなみに `-r` オプションでダブルクォートは消える

```
$ cat test.json | jq -r '.results[] | .address1'
香川県
東京都
千葉県
```

### 注意

`[]`がないとだめ
シングルクォーテーションもないとだめ

```
$ cat test.json | jq '.results.address1'
jq: error (at <stdin>:36): Cannot index array with string "address1"

$ cat test.json | jq '.results | .address1'
jq: error (at <stdin>:36): Cannot index array with string "address1"

$ cat test.json | jq .results[].address1
zsh: no matches found: .results[].address1
```

### value を検索する

select で value の検索ができる

```
$ cat test.json | jq '.results[] | select(.address1 == "千葉県")'
{
  "address1": "千葉県",
  "address2": "千葉市中央区",
  "address3": "",
  "kana1": "ﾁﾊﾞｹﾝ",
  "kana2": "ﾁﾊﾞｼﾁｭｳｵｳｸ",
  "kana3": "",
  "prefcode": "12",
  "zipcode": "2600000"
}
```

'and/or' で複数条件も可能

```
cat test.json | jq '.results[] | select(.address1 == "千葉県" or .address1 == "東京都")'
{
  "address1": "東京都",
  "address2": "足立区",
  "address3": "",
  "kana1": "ﾄｳｷｮｳﾄ",
  "kana2": "ｱﾀﾞﾁｸ",
  "kana3": "",
  "prefcode": "13",
  "zipcode": "1200000"
}
{
  "address1": "千葉県",
  "address2": "千葉市中央区",
  "address3": "",
  "kana1": "ﾁﾊﾞｹﾝ",
  "kana2": "ﾁﾊﾞｼﾁｭｳｵｳｸ",
  "kana3": "",
  "prefcode": "12",
  "zipcode": "2600000"
}
```

# 取得したデータを整形して出力

### データを再形成

パイプで渡した後に、.key で指定した key の value を指定可能

```
$ cat test.json | jq '.results[] | select(.address1 == "千葉県") | { prefecture : .address1, zipcode: .zipcode }'
{
  "prefecture": "千葉県",
  "zipcode": "2600000"
}
```

このように `(.key)` で、value を key として再編成することができる。
以下は `都道府県:カナ` の形式で出力してみた。

```
$ at test.json | jq '.results[] | select(.address1 == "千葉県") | { (.address1) : .kana1 }'
{
  "千葉県": "ﾁﾊﾞｹﾝ"
}
```

# 演習

### `curl` と組み合わせて自分の github のリポジトリを列挙する

github の API で取れるアカウント情報には、リポジトリ一覧を取得するための URL が格納されている。

```
$ curl -s https://api.github.com/users/miyajuggler
{
  "login": "miyajuggler",
  "id": 85389214,
  "node_id": "MDQ6VXNlcjg1Mzg5MjE0",
  "avatar_url": "https://avatars.githubusercontent.com/u/85389214?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/miyajuggler",
  "html_url": "https://github.com/miyajuggler",
  "followers_url": "https://api.github.com/users/miyajuggler/followers",
  "following_url": "https://api.github.com/users/miyajuggler/following{/other_user}",
  "gists_url": "https://api.github.com/users/miyajuggler/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/miyajuggler/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/miyajuggler/subscriptions",
  "organizations_url": "https://api.github.com/users/miyajuggler/orgs",
  "repos_url": "https://api.github.com/users/miyajuggler/repos",
  "events_url": "https://api.github.com/users/miyajuggler/events{/privacy}",
  "received_events_url": "https://api.github.com/users/miyajuggler/received_events",
  "type": "User",
  "site_admin": false,
  "name": "Naohiro Miyazaki",
  "company": null,
  "blog": "",
  "location": null,
  "email": null,
  "hireable": null,
  "bio": null,
  "twitter_username": null,
  "public_repos": 13,
  "public_gists": 0,
  "followers": 0,
  "following": 4,
  "created_at": "2021-06-05T08:22:46Z",
  "updated_at": "2022-01-15T05:10:58Z"
}
```

そのため、github API で リポジトリ一覧を取得するための URL を取得 => リポジトリ一覧を取得するための URL を 使って リポジトリを列挙する。
つまり 2 回 curl コマンドを使う。

**`` で囲めば、出力結果をコマンドの特定の位置におけるので、1 行で書ける。（変数格納する必要なし！ xargs 使う必要なし！）**

```
$ curl -s `curl -s https://api.github.com/users/miyajuggler | jq -r .repos_url` | jq '.[].name'
"aws-cli-practice"
"diff-practice"
"git-practice"
"kubernetes-basics"
"kubernetes-practice"
"main-project"
"my-first-repo"
"product-registry"
"revert-reset-practice"
"sample-repo"
"shellscript-practice"
"sub-project"
"typescript-for-javascript-developers"
```

# 参考

[jq コマンドで json から必要なデータのみを取得する
](https://qiita.com/buntafujikawa/items/a769ebabbdd324ff0d6f)
