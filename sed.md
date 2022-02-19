# sed

## テンプレ

```sh
$ val=AAA

$ echo 'AAA BBB CCC' | sed -e "s/$val/hoge/"
hoge BBB CCC

$ echo 'AAA BBB CCC' | sed -e "s/CCC/$val/"
AAA BBB AAA
```
