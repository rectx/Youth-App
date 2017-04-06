//
//  ApiService.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/3/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

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
        URLSession.shared.dataTask(with: url!) { data, reponse, error in
            if error != nil {
                print(error!)
                return
            }
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                        DispatchQueue.main.async {
                            completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                        }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}

/*
 let url = URL(string: urlString)
 
 URLSession.shared.dataTask(with: url!) {data, reponse, error in
 if error != nil {
 print(error!)
 return
 }
 
 do {
 let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
 
 var videos = [Video]()
 
 for dictionary in json as! [[String: AnyObject]] {
 let video = Video()
 video.title = dictionary["title"] as? String
 video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
 video.numberOfView = dictionary["number_of_views"] as? NSNumber
 let channelDictionary = dictionary["channel"] as! [String: AnyObject]
 let channel = Channel()
 channel.name = channelDictionary["name"] as? String
 channel.profileImageName = channelDictionary["profile_image_name"] as? String
 video.channel = channel
 videos.append(video)
 }
 
 DispatchQueue.main.async {
 completion(videos)
 }
 } catch let jsonError {
 print(jsonError)
 }
 
 }.resume()
 }
 */
