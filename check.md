#!/bin/bash
set -euo pipefail

name="midori"

names=$(cat family.json | jq '.miyazaki[] | .name')

read -r -p $name"の検索を開始しますか？ (y/N): " yn
case "$yn" in
    [yY]*) echo "処理を開始します.";;
    *) echo "処理を終了します." ; exit ;;
esac

if [[ `echo $names | grep $name` ]] ; then
    echo 'ありました'

    age=$(cat family.json | jq '.miyazaki[] | select(.name == "'"$name"'") | .age')
    echo $age "歳です。"
    echo '処理を終了します.'
    # exit
fi
