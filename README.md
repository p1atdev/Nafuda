# Nafuda
## English
TODO: write here

## Japanese
NafudaはWebサイトのタイトルの取得を容易にするライブラリです

### インストール
`Pod`ファイル
```Ruby
pod 'Nafuda'
```

### 使い方
```Swift

Nafuda(link: "https://github.com/p1atdev/Nafuda").getTitle(completion: { title in
    print(title!)   //-> "p1atdev/Nafuda · GitHub"
})

```
