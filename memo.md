## 確認系テンプレ

```
read -p "ok? (y/N): " yn
case "$yn" in
    [yY]*) echo hello;;
    *) echo "abort";;
esac
```

## 文字列 A に文字列 B が含まれるか

```
if [ `echo 'hogefuga' | grep 'fuga'` ] ; then
    echo 'ok'
fi
```

### こちらは OK は出力されず

```
if [ `echo 'hogefuga' | grep 'aaa'` ] ; then
    echo 'ok'
fi

read -r -p "検索を開始します。よろしいですか？ (y/N): " yn
case "$yn" in
    [yY]*) echo "処理を開始します.";;
    *) echo "処理を終了します." ; exit ;;
esac
```

## 出力を一列で

```
aaa=("7.7.7.5/32" "7.7.7.4/32" "7.7.7.6/32" "1.1.1.1/32" "7.7.7.1/32")
echo ${aaa[@]} | xargs -n1
```

## 自宅ローカル IP 取得

```
curl -s https://api.ipify.org
```

## &>/dev/null と >/dev/null

### &>/dev/null

`/dev/null 2>&1` と同じ。
標準出力と標準エラー出力の両方共を破棄する。

```sh
# 何も帰ってこない
echo hello &>/dev/null

# 何も帰ってこない
$ aaaaaaa hello &>/dev/null

```

### /dev/null

`1>/dev/null` と同じ。標準出力を捨てる。

例えば以下のコマンドでは何も出力が帰ってこない

```sh
# 何も帰ってこない
$ echo hello >/dev/null

# エラーは帰ってくる
$ aaaaaaa hello >/dev/null
zsh: command not found: aaaaaaa
```

## エイリアス

```
CERTIFICATE_ARN=$(aws acm request-certificate \
  --domain-name *.${MY_DOMAIN} \
  --validation-method DNS \
  --query "CertificateArn" --output text) && echo $CERTIFICATE_ARN
```

## sed

```sh
sed -i -e "s/%VALIDATION_RECORD_NAME%/$VALIDATION_RECORD_NAME/" $VALIDATION_RECORD_FILE
```

## git 配下の変更初期化

```sh
# Initialize
git restore $VALIDATION_RECORD_FILE
```

## 容量確認系

```sh
# ファイルの容量がわかるコマンド
$ du -s example.mp3

# カレントディレクトリにあるファイルすべての容量を表示
$ du -ah
```

```sh
# df - ファイル・システム内のフリー・スペースの量を表示する
$ df -h
```

```sh
# 環境変数が見れる
$ env
```

## コマンドの中で変数を使う場合

['"$aaa"'] で囲む。よく使う

```sh
$ curl -X POST -H 'Content-Type: application/json' --data '{"text":"'"$fuga"'"}' https://〜〜
```

テキストのみ

```sh
$ curl -X POST -H 'Content-Type: application/json' --data '{"text":"hogehoge"}' https://〜〜
```

テキストと変数

```sh
$ curl -X POST -H 'Content-Type: application/json' --data '{"text":"hogehoge'"$fuga"'"}' https://〜〜
```

## その他よく使うコマンド

```sh
# ディレクトリの中見ごと消す
$ rm -r <ディレクトリ名>
```
