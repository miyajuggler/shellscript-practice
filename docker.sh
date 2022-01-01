# IDを指定して名前の部分だけ出力
docker ps -f "id=21a2a1f5d5bd" -a --format "{{.Names}}"

# IDを指定して名前の部分だけ出力その2
docker ps -a | grep "21a2a1f5d5bd" | awk -F ' ' '{print $(NF)}'
docker ps -a | grep "21a2a1f5d5bd" | awk '{print $(NF)}'

# 名前を指定してIDのみ出力
docker ps -f "name=product-register_web_1" -a --format "{{.ID}}"

# 名前を指定してIDのみ出力その2
docker ps -a | grep "product-register_web_1" | awk -F ' ' '{print $(1)}'
docker ps -a | grep "product-register_web_1" | awk '{print $(1)}'

# 名前を指定してIDのみ出力その3
docker ps -f "name=product-register_web_1" -a -q


# ステータスが「Exited」のやつだけgrepで絞りこみ
$ docker ps -a | grep "Exited"

# 「awk」でコンテナ名だけ抜き出す
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}'

# 「xargs docker start」にパイプして全部start
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}' | xargs docker start
