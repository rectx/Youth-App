//
//  ApiService.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/3/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit
import Alamofire

class ApiService: NSObject {
    
    private var a: Int?
    
    static let shareInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(Constants.baseURL)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(Constants.baseURL)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(Constants.baseURL)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        Alamofire.request(url!).responseJSON(completionHandler: { (response) in
            guard response.result.isSuccess else {
                print("Error: \(response.result.error)")
                return
            }
            if let data = response.result.value as? [[String: AnyObject]] {
                DispatchQueue.main.async {
                    completion(data.map({return Video(dictionary: $0)}))
                }
            }
        })
    }
}
