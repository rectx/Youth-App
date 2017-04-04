//
//  ApiService.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/3/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let shareInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
        let url = URL(string: Constants.homeURL)

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
}
