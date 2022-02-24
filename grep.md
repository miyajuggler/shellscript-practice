# grep

## 基本

ファイル名を指定して grep をかけたり、コマンドの実行結果に対して grep をかけたりする。  
個人的に後者の方をよく使っている。

ファイル名を指定して grep 例

```sh
$ grep address test.json
      "address1": "香川県",
      "address2": "高松市",
      "address3": "",
      "address1": "東京都",
      "address2": "足立区",
      "address3": "",
      "address1": "千葉県",
      "address2": "千葉市中央区",
      "address3": "",
```

`$ grep address ./*` とかすれば、現在いるディレクトリのすべてのファイルに対して検索をかけることができる。

コマンド実行結果に対して grep 例

```sh
$ kubectl get po -A | grep kubernetes
kubernetes-dashboard   dashboard-metrics-scraper-5594697f48-v7cjw   1/1   Running   51    64d
kubernetes-dashboard   kubernetes-dashboard-57c9bfc8c8-jdfjg        1/1   Running   63    64d
```

## オプション

### -i

大文字と小文字を区別せず検索する。

### -v

一致しないものを検索する。

### -e

検索したいものを羅列することができる。

### egrep

egrep コマンドの動作は -E オプションを指定した grep コマンドと同じ

### 活用例

```sh
# 立ち上がっていない pod を見る（4/4 以上は拾ってしまう）
$ kubectl get po -A | grep -v -e 1/1 -e 2/2 -e 3/3 | grep -v completed
$ kubectl get po -A | grep -v '1/1\|2/2\|3/3' | grep -v completed

# node の名前と taints の情報を見る
$ kubectl describe no | grep -e Name: -e Taints:
$ kubectl describe no | grep 'Name:\|Taints:'
$ kubectl describe no | egrep "Name:|Taints:"

#  ステータスが「Exited」のやつだけ grep で絞りこみ、名前の部分を awk コマンドで抜き出す
$ docker ps -a | grep "Exited" | awk -F ' ' '{print $(NF)}'
```
