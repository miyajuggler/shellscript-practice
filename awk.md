# awk

## 基本

awk は入力として受け取った文字列に対して、フィールド区切り文字やレコード区切り文字を指定して、「列」に対する処理を行うためのコマンド

## 例

コンマ区切り

```bash
# 全部出す
$ echo "111,222,333,444" | awk -F ',' '{print $0}'
111,222,333,444

# カンマ区切りの1つ目を取得
$ echo "111,222,333,444" | awk -F ',' '{print $1}'
111

# カンマ区切りの3つ目取得
$ echo "111,222,333,444" | awk -F ',' '{print $3}'
333

# 末尾取得
$ echo "111,222,333,444" | awk -F ',' '{print $(NF)}'
444
$ echo "111,222,333,444" | awk -F ',' '{print $(NF-0)}'
444

# 末尾から1つ後ろ取得
$ echo "111,222,333,444" | awk -F ',' '{print $(NF-1)}'
333
```

スペース区切り

```bash
# スペース区切りの1つ目を取得
$ echo "111 222 333 444" | awk '{print $1}'

# 明示的に-Fを入れてもおｋ
$ echo "111 222 333 444" | awk -F ' ' '{print $1}'
111

# スペース区切りの3つ目取得
$ echo "111 222 333 444" | awk '{print $3}'
333

# 末尾取得
$ echo "111 222 333 444" | awk '{print $(NF)}'
444
$ echo "111 222 333 444" | awk '{print $(NF-0)}'
444

# 末尾から1つ後ろ取得
$ echo "111 222 333 444" | awk '{print $(NF-1)}'
333
```

## 応用

docker コマンドで応用してみる

`docker ps -a`の output はこんなかんじ

```bash
CONTAINER ID   IMAGE                    COMMAND                  CREATED              STATUS                      PORTS                                       NAMES
9a390f3ad071   kubernetesui/dashboard   "/dashboard --insecu…"   About a minute ago   Up About a minute                                                       k8s_kubernetes-dashboard_kubernetes-dashboard-57c9bfc8c8-jdfjg_kubernetes-dashboard_52faf46c-e1e3-43d3-b2ee-82d8f7e15438_12
9ab2300e9e7e   a262dd7495d9             "/metrics-sidecar"       2 minutes ago        Up 2 minutes                                                            k8s_dashboard-metrics-scraper_dashboard-metrics-scraper-5594697f48-v7cjw_kubernetes-dashboard_9c2936c5-058f-4160-a25a-760fee6356d9_11
21a2a1f5d5bd   4df0e95ba434             "irb"                    4 months ago         Exited (255) 4 months ago   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   product-register_web_1
a99e44d4a392   0904b518ad08             "docker-entrypoint.s…"   4 months ago         Exited (255) 4 months ago   5432/tcp                                    product-register_db_1
84288af6aea6   4280b192841f             "jupyter lab --ip=0.…"   5 months ago         Exited (1) 5 months ago                                                 my-lab
```

今回はスペース区切りなので前半の `''` は`' '` にする

```bash
# IDを指定して名前のみだけ出力
$ docker ps -a | grep "21a2a1f5d5bd" | awk -F ' ' '{print $(NF)}'

# 名前を指定してIDのみを出力
$ docker ps -a | grep "product-register_web_1" | awk -F ' ' '{print $(1)}'
```

最初の`-F`はなくてもいける

```bash
# IDを指定してのみだけ出力
$ docker ps -a | grep "21a2a1f5d5bd" | awk '{print $(NF)}'

# 名前を指定してIDのみを出力
$ docker ps -a | grep "product-register_web_1" | awk '{print $(1)}'
```

```bash
# ステータスが「Exited」のやつだけgrepで絞りこみ
$ docker ps -a | grep "Exited"

# 「awk」でコンテナ名だけ抜き出す
$ docker ps -a | grep "Exited" | awk '{print $(NF)}'

# 「xargs docker start」にパイプして全部start
$ docker ps -a | grep "Exited" | awk '{print $(NF)}' | xargs docker start
```

## 参考

- [awk とか xargs とか sed をそろそろ日常的に使っていきたい人のメモ](https://7me.nobiki.com/2017/04/27/awk-xargs-sed-memo/)
- [awk の-F オプションで区切り文字を指定する方法](https://it-ojisan.tokyo/awk-f/)
