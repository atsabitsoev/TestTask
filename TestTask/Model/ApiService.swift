//
//  ApiService.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ApiService {
    
    private init() {}
    static let standard = ApiService()
    
    var currentArrayOfProducts = [Product]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("productsUpdated"), object: nil)
        }
    }
    var currentTopic = Topic(name: "Tech", id: 352) {
        didSet {
            print("didset")
            ApiService.standard.setArrayOfProducts()
        }
    }
    
    
    
    
    // PRODUCTS
    func setArrayOfProducts() {
        print("hello")
        NotificationCenter.default.post(name: NSNotification.Name("loadingProductsStarted"), object: nil)
        
        let url = URL(string: "https://api.producthunt.com/v1/posts/all?search[topic]=\(currentTopic.id)")!

        let params: [String: String] = ["page":"1",
                                        "per_page":"50",
                                        "search[topic]": "\(currentTopic.id)",
                                        "sort_by":"votes_count"]
        
        let headers = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                       "Host": "api.producthunt.com"]
        
        var arrayOfProducts = [Product]()
        
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding(arrayEncoding: .noBrackets),
                          headers: headers).responseJSON
            { (response) in
                
                switch response.result {
                    
                case .success:
                    
                    let jsonString = response.result.value
                    let jsonArray = JSON(jsonString!).dictionaryValue["posts"]?.arrayValue ?? []
                    
                    for jsonProduct in jsonArray {
                        
                        let name = jsonProduct.dictionaryValue["name"]!.stringValue
                        let tagline = jsonProduct.dictionaryValue["tagline"]!.stringValue
                        let upvotes = jsonProduct.dictionaryValue["votes_count"]!.intValue
                        let thumbnailUrl = jsonProduct.dictionaryValue["thumbnail"]!["image_url"].url!
                        let screenshotUrl = jsonProduct.dictionaryValue["screenshot_url"]!.first!.1.url!
                        let link = jsonProduct.dictionaryValue["redirect_url"]!.url!
                        
                        let product = Product(name: name,
                                              tagline: tagline,
                                              upvotes: upvotes,
                                              thumbnailUrl: thumbnailUrl,
                                              screenshotUrl: screenshotUrl,
                                              link: link)
                        
                        arrayOfProducts.append(product)
                        
                    }
                    
                    self.currentArrayOfProducts = arrayOfProducts
                    
                case .failure:
                    
                    print(response.result.error)
                    
                }
                
            }
        
    }
    
    
    // TOPICS
    var topicsArray = [Topic]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("topicsUpdated"), object: nil)
        }
    }
    func setTopicsArray() {
        
        let url = URL(string: "https://api.producthunt.com/v1/topics?search[trending]=true")!
        
        let params: [String: String] = ["page":"1",
                                        "per_page":"10",
                                        "search[trending]":"true"]
        
        let headers = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                       "Host": "api.producthunt.com"]
        
        var arrayOfTopics = [Topic]()
        
        Alamofire.request(url,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding(arrayEncoding: .noBrackets),
                          headers: headers).responseJSON { (response) in
                            
                            let jsonString = response.result.value
                            let jsonArray = JSON(jsonString!).dictionaryValue["topics"]?.arrayValue ?? []
                            
                            for jsonTopic in jsonArray {
                                
                                let name = jsonTopic["name"].stringValue
                                let id = jsonTopic["id"].intValue
                                
                                let topic = Topic(name: name, id: id)
                                
                                arrayOfTopics.append(topic)
                                
                            }
                            
                            self.topicsArray = arrayOfTopics
                            
        }
        
    }
    

}
