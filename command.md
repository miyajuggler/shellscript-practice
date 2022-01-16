## curl

```
curl -s "https://qiita.com/api/v2/users/ryuichi1208" | jq .
```

- sample json

```
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

```

```
