read -p "ok? (y/N): " yn
case "$yn" in
    [yY]*) echo hello;;
    *) echo "abort";;
esac

# 文字列Aに文字列Bが含まれるか
if [ `echo 'hogefuga' | grep 'fuga'` ] ; then
    echo 'ok'
fi

# こちらはOKは出力されず
if [ `echo 'hogefuga' | grep 'aaa'` ] ; then
    echo 'ok'
fi

read -r -p "検索を開始します。よろしいですか？ (y/N): " yn
case "$yn" in
    [yY]*) echo "処理を開始します.";;
    *) echo "処理を終了します." ; exit ;;
esac



# 出力を一列で
aaa=("7.7.7.5/32" "7.7.7.4/32" "7.7.7.6/32" "1.1.1.1/32" "7.7.7.1/32")
echo ${aaa[@]} | xargs -n1

# 自宅ローカルIP取得
curl -s https://api.ipify.org



&>/dev/null と >/dev/null
&>/dev/null
>/dev/null 2>&1と同じ。
標準出力と標準エラー出力の両方共を破棄する。

>/dev/null
1>/dev/nullと同じ。標準出力を捨てる。
