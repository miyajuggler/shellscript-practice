# curl

## 基本

以下のように API を実行することができる。
出力内容整形については jq を参考にする。

```bash
curl -s "https://qiita.com/api/v2/users/ryuichi1208" | jq .
```

## 基本形

```bash
# HTTPリクエストを実施し結果を標準出力へ
$ curl http://対象のURL

# コンマや[]を使って範囲指定も出来る
$ curl 'http://{one,two,three}.example.com'
$ curl 'http://[1-3].example.com'

# 実行結果をファイルへ出力
$ curl http://対象のURL > 出力先
$ curl -o 出力先PATH http://対象のURL

# ファイル出力時の進捗状況を非表示にする(エラーも非表示)
$ curl -s -o 出力先PATH http://対象のURL

# 上記でエラーは表示したい場合
$ curl -sS -o 出力先PATH http://対象のURL

# プログレスバーで進捗率を表示
$ curl -# -O http://対象のURL

# SSL接続で証明書エラーをスキップ
$ curl -k https://対象のURL

# URLのファイル名でダウンロード (下記はindex.htmlで保存される)
$ curl -O http://対象のURL/index.html

# プロキシ経由でアクセスする
$ curl -x プロキシサーバ:ポート番号 --proxy-user ユーザ名:パスワード http://対象のURL

# リダイレクトを有効にする
$ curl -L http://対象のURL

# ダウンロードを中断したときに再度ダウンロードを再開するとき
$ curl -C - http://対象のURL

# HTTPメソッドの指定（-X）
$ curl -X PUT http://対象のURL
```

## よく使うオプション

- `-L` リダイレクトがあったらリダイレクト先の情報を取る
- `-s` 余計な出力をしない
- `-o` レスポンスボディの出力先を指定する

```bash
$ curl -s "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060"
{
        "message": null,
        "results": [
                {
                        "address1": "高知県",
                        "address2": "南国市",
                        "address3": "蛍が丘",
                        "kana1": "ｺｳﾁｹﾝ",
                        "kana2": "ﾅﾝｺｸｼ",
                        "kana3": "ﾎﾀﾙｶﾞｵｶ",
                        "prefcode": "39",
                        "zipcode": "7830060"
                }
        ],
        "status": 200
}
```

### post

```bash
$ curl -X POST -H "Content-Type: application/json" -d '{"Name":"sensuikan1973", "Age":"100"}' localhost:8080/api/v1/users
```

## デバッグ系

```bash
# HTTPレスポンスヘッダーの取得（-I）
$ curl -I http://対象のURL

# 詳細をログ出力（-vもしくは--verbose）
$ curl -v http://対象のURL

# 終了ステータスのみを表示
$ curl -s http://対象のURL -o /dev/null -w '%{http_code}\n'
```

```bash
curl -I "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060"
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Content-Type: text/plain;charset=utf-8
X-Cloud-Trace-Context: ebf807ff45925dbe1981b7c5ba8bb181
Content-Length: 290
Date: Sun, 16 Jan 2022 09:24:49 GMT
Server: Google Frontend
```

`-v` を付けると、リクエストヘッダは > で表示され、レスポンスヘッダは < で表示される。どちらも標準エラー出力で表示される。

```bash
$ curl -v "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060"
*   Trying 2404:6800:4004:820::2013:80...
* Connected to zipcloud.ibsnet.co.jp (2404:6800:4004:820::2013) port 80 (#0)
> GET /api/search?zipcode=7830060 HTTP/1.1
> Host: zipcloud.ibsnet.co.jp
> User-Agent: curl/7.77.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
< Content-Type: text/plain;charset=utf-8
< X-Cloud-Trace-Context: d779e553e95cb09dc96c0fbf006dcd9f
< Date: Sun, 16 Jan 2022 09:23:33 GMT
< Server: Google Frontend
< Content-Length: 290
<
{
        "message": null,
        "results": [
                {
                        "address1": "高知県",
                        "address2": "南国市",
                        "address3": "蛍が丘",
                        "kana1": "ｺｳﾁｹﾝ",
                        "kana2": "ﾅﾝｺｸｼ",
                        "kana3": "ﾎﾀﾙｶﾞｵｶ",
                        "prefcode": "39",
                        "zipcode": "7830060"
                }
        ],
        "status": 200
* Connection #0 to host zipcloud.ibsnet.co.jp left intact
```

```bash
$ curl -s "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060" -o /dev/null -w '%{http_code}\n'
200
```

## 結果に応じてコマンドを実行

```bash
$ curl -s "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060" | grep "北海道" >/dev/null 2>&1 && echo "hoge"

$ curl -s "http://zipcloud.ibsnet.co.jp/api/search?zipcode=7830060" | grep "高知県" >/dev/null 2>&1 && echo "hoge"
hoge
```

## CRUD 処理のテンプレ

```sh
# get
curl -s http://localhost:5000/v1/organizations

curl -X POST -H "Content-Type: application/json" -d '{"userId": "aguroaguro-a", "userName": "あぐろあぐろ","organizationId": 3}' http://localhost:5000/v1/users

curl -X PUT -H "Content-Type: application/json" -d '{"userId": "aguroaguro-a", "userName": "あーぐーろー","organizationId": 3}' http://localhost:5000/v1/users/aguroaguro-a

curl -X DELETE http://localhost:5000/v1/users/aguroaguro-a
```

## 参考

- [よく使う curl コマンドのオプション](https://qiita.com/ryuichi1208/items/e4e1b27ff7d54a66dcd9)
- [curl コマンドで api を叩く](https://qiita.com/buntafujikawa/items/758425773b2239feb9a7)
