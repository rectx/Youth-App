//
//  FeedCell.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/3/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var videos: [Video]?
    
    private func fetchVideos() {
        ApiService.shareInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        backgroundColor = UIColor.brown
        addSubview(collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: Constants.identifierCell)
    }
    
    override func setupConstraints() {
        addConstraintsWithFormat(format: "H:|[v0]|", views: self.collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: self.collectionView)
    }
}

extension FeedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifierCell, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
}

extension FeedCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
