//
//  ViewController.swift
//  Youth App
//
//  Created by Thuan Tran on 3/25/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "Thuan Tran"
//        kanyeChannel.profileImageName = "kanye_profile"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfView = 3278485319
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfView = 91439124124
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    var videos: [Video]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchVideos()
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: Constants.identifierCell)
        self.collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButton()
    }
    
    private func fetchVideos() {
        let url = URL(string: Constants.homeURL)
        URLSession.shared.dataTask(with: url!) {data, reponse, error in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()
    
    private func setupMenuBar() {
        self.view.addSubview(menuBar)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        self.view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButton() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    func handleSearch() {
        print("handleSearch()")
    }
    
    func handleMore() {
        print("handleMore()")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: Constants.identifierCell, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.view.frame.width, height: height + 16 + 88)
    }
}

