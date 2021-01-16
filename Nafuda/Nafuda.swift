//
//  Nafuda.swift
//  Nafuda
//
//  Created by 周廷叡 on 2021/01/16.
//

import UIKit
import Foundation

public class Nafuda {
    
    //対象のURL
    let targetURL: URL
    
    var request: NSMutableURLRequest
    
    //サイトの名前を取得する
    public func getTitle(completion: @escaping(String?) -> ()) {
        
        // セマフォの初期化
        let semaphore = DispatchSemaphore(value: 0)
        
        //getにする
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            print(self.targetURL)
            
            if let htmlData = String(data: data!, encoding: .utf8) {
                print(htmlData)
                
                if let title = htmlData.searchMatchBetween(from: "<title>", to: "</title>") {
                    //タイトルを返す
                    completion(title)
                } else {
                    //nilを返す
                    completion(nil)
                }
            }
            
            // 処理終了でセマフォをインクリメント
            semaphore.signal()
        })
        
        //通信
        task.resume()
        
        // デクリメントして待つ
        semaphore.wait()
        
    }
    
    public init(link: String) {
        self.targetURL = URL(string: link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        self.request = NSMutableURLRequest(
            url: targetURL,
            cachePolicy: .reloadIgnoringCacheData,
            timeoutInterval: 100
        )
    }
    
}

//返すやつ
class NafudaResponse {
    
    //成功したかどうか
    public let status: Status
    
    public let title: String?
    
    enum Status {
        case success
        case fail
        case error
    }
    
    public init(status: Status, title: String?) {
        self.status = status
        self.title = title
    }
}

//正規表現
extension String {
    
    func searchMatchBetween(from: String, to: String) -> String? {
        //from -> 初めのワード
        //to -> 終わりのワード
        
        //toで分割
        //分割できた場合
        if self.components(separatedBy: to).count != 1 {
            
            let firstSeparated = self.components(separatedBy: to)[0]  //1
            if firstSeparated.components(separatedBy: from).count == 1 { return nil }
                //分割できたら
            return firstSeparated.components(separatedBy: from)[1]
                
        } else {
            //分割されなかった場合
            return nil
        }
    }
    
}
