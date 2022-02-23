# docker

## いろいろあそび

### ID を指定して名前の部分だけ出力

```sh
docker ps -f "id=21a2a1f5d5bd" -a --format "{{.Names}}"
```

### ID を指定して名前の部分だけ出力その 2

```sh
docker ps -a | grep "21a2a1f5d5bd" | awk -F ' ' '{print $(NF)}'
docker ps -a | grep "21a2a1f5d5bd" | awk '{print $(NF)}'
```

### 名前を指定して ID のみ出力

```sh
docker ps -a -f "name=product-register_web_1" -a --format "{{.ID}}"
```

### 名前を指定して ID のみ出力その 2

```sh
docker ps -a | grep "product-register_web_1" | awk -F ' ' '{print $(1)}'
docker ps -a | grep "product-register_web_1" | awk '{print $(1)}'
```

### 名前を指定して ID のみ出力その 3

```sh
docker ps -f "name=product-register_web_1" -a -q
```

### ステータスが「Exited」のやつだけ grep で絞りこみ

```sh
$ docker ps -a | grep "Exited"
21a2a1f5d5bd   4df0e95ba434             "irb"                    5 months ago   Exited (255) 5 months ago   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   product-register_web_1
a99e44d4a392   0904b518ad08             "docker-entrypoint.s…"   5 months ago   Exited (255) 5 months ago   5432/tcp                                    product-register_db_1
84288af6aea6   4280b192841f             "jupyter lab --ip=0.…"   5 months ago   Exited (1) 5 months ago
```

### 「awk」でコンテナ名だけ抜き出す

```sh
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}'
product-register_web_1
product-register_db_1
my-lab
```

### 「xargs docker start」にパイプして全部 start

```sh
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}' | xargs docker start
```

### -p をつけることで実行コマンドを確認できる

```sh
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}' | xargs -p docker start
docker start product-register_web_1 product-register_db_1 my-lab?...
```

### Docker image のレイヤ構造は docker history で確認

```sh
$ docker history <image ID>
```

08 のメモ参照の Dockerfile

```Dockerfile
FROM ubuntu:latest
RUN mkdir sample
WORKDIR /sample
RUN touch test
```

image 作成 & コンテナを建てる

```sh
$ docker build .
$ docker run -it c21f80823323 bash
```

```
$ docker history c21f80823323
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
c21f80823323   39 hours ago   RUN /bin/sh -c touch test # buildkit            0B        buildkit.dockerfile.v0
<missing>      39 hours ago   WORKDIR /sample                                 0B        buildkit.dockerfile.v0
<missing>      39 hours ago   RUN /bin/sh -c mkdir sample # buildkit          0B        buildkit.dockerfile.v0
<missing>      2 weeks ago    /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>      2 weeks ago    /bin/sh -c #(nop) ADD file:3acc741be29b0b58e…   65.6MB
```
