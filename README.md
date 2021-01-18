# Nafuda
## English
Nafuda is a library that can get web site's title easily!
In Japanese, "Nafuda" means a nameplate.

todo: write here

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

//get title
Nafuda(link: "https://github.com/p1atdev/Nafuda").getTitle(completion: { response in
    switch response.status {
    case .success:
        print("Success! The title of the site is \(response.data!)")
        
    case .fail:
        print("Faild. The site may not have a title.")
        
    case .error:    //TODO: I'll change the name of this one later.
        print("Faild. The site could not be accessed. The site may not exist.)
    
    }
})

//get favicon
Nafuda(link: "https://github.com/p1atdev/Nafuda").getFavicon(completion: { response in
    switch response.status {
    case .success:
        print("Success! The favicon of the site is \(response.data!)")
        
    case .fail:
        print("Faild. The site may not have a favicon.")
        
    case .error:    //TODO: I'll change the name of this one later.
        print("Faild. The site could not be accessed. The site may not exist.)
    
    }
})
```
