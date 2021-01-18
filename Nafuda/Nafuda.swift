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
    public func getTitle(completion: @escaping(NafudaResponse) -> ()) {
        
        // セマフォの初期化
        let semaphore = DispatchSemaphore(value: 0)
        
        //getにする
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if data != nil {
                
                if let htmlData = String(data: data!, encoding: .utf8) {
                    
                    if let title = htmlData.searchMatchBetween(from: "<title>", to: "</title>") {
                        //タイトルを返す
                        completion(NafudaResponse(status: .success, data: title))
                    } else {
                        //nilを返す
                        completion(NafudaResponse(status: .fail , data: nil))
                    }
                }
            } else {
                //nilを返す
                completion(NafudaResponse(status: .error , data: nil))
            }
            
            // 処理終了でセマフォをインクリメント
            semaphore.signal()
        })
        
        //通信
        task.resume()
        
        // デクリメントして待つ
        semaphore.wait()
        
    }
    
    
    //faviconの取得
    public func getFavicon(completion: @escaping(NafudaResponse) throws -> ()) {
        
        // セマフォの初期化
        let semaphore = DispatchSemaphore(value: 0)
        
        //getにする
        request.httpMethod = "GET"
        
        //urlをファビコンのやつに変更する
        request.url = {
            
            do {
                
                //元のurl
                let oldURL = request.url!.absoluteString
                
                //                print("old: ", oldURL)
                
                //ドメインの取得
                let domain = oldURL.searchMatchBetween(from: "://", to: "/")
                
                //                print("Domain: ", "https://" + domain! + "/favicon.ico")
                
                if oldURL.prefix(5) == "https" {
                    //httpsの場合
                    return URL(string: "https://" + domain! + "/favicon.ico")
                    
                } else if oldURL.prefix(5) == "http:" {
                    //httpの場合
                    return  URL(string: "http://" + domain! + "/favicon.ico")
                } else {
                    
                    throw NafudaError.invalidUrl    //不正なURL
                    
                }
                
            } catch {
                
            }
            
            return nil
            
        }()
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            do {
                
                if data != nil {
                    
                    print(type(of: data))
                    
                    try completion(NafudaResponse(status: .success, data: data))
                    
                } else {
                    //nilを返す
                    try completion(NafudaResponse(status: .error , data: nil))
                    
                }
                
            } catch {
                
                
                
                
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
public class NafudaResponse {
    
    //成功したかどうか
    public let status: NafudaResponseStatus
    
    public let data: Any?
    
    public init(status: NafudaResponseStatus, data: Any?) {
        self.status = status
        self.data = data
    }
}

public enum NafudaResponseStatus {
    case success
    case fail
    case error
}

enum NafudaError: Error {
    case invalidUrl
    case server(Int) // Int型を引数とする
    case unknown(String) // String型を引数とする
}

//正規表現
extension String {
    
    func searchMatchBetween(from: String, to: String) -> String? {
        //from -> 初めのワード
        //to -> 終わりのワード
        
        //toで分割
        //分割できた場合
        for separated in self.components(separatedBy: to).reversed() {
            
            for secondSeparated in self.components(separatedBy: from) {
                
                if !secondSeparated.hasPrefix(separated) { continue }
                
                return separated
                
            }
        }
        
        //2周目
        for separated in self.components(separatedBy: from) {
            
            if separated.contains(to) {
                
                return separated.components(separatedBy: to)[0]
                
            }
        }
        
        
        //分割されなかった場合
        return nil
        
    }
    
}
