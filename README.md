# Nafuda
## English
Nafuda is a library that can get web site's title easily!
In Japanese, "Nafuda" means a nameplate.

TODO: write here

## Japanese
NafudaはWebサイトのタイトルの取得を容易にするライブラリです。
名前の由来は「名札」からきています（KannaやJiみたいな感じにした)

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
