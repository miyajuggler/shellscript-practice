# 準備

まず同じ階層にこのような json ファイルを作っておく。

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

# 確認

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

```
$ cat test.json | jq '.results[] | select(.address1 == "千葉県") | { prefecture : .address1, zipcode: .zipcode }'
{
  "prefecture": "千葉県",
  "zipcode": "2600000"
}
```
