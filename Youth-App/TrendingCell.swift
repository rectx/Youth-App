//
//  TrendingCell.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/4/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.shareInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
