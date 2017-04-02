//
//  SettingLauncher.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/1/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import Foundation
import UIKit

class SettingLauncher: NSObject, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    let cellHeight:CGFloat = 50
    
    let settings: [Setting] = {
        return [
            Setting(name: "Settings", imageName: "settings"),
            Setting(name: "Terms & privacy policy", imageName: "privacy"),
            Setting(name: "Send Feedback", imageName: "feedback"),
            Setting(name: "Help", imageName: "help"),
            Setting(name: "Switch Account", imageName: "switch_account"),
            Setting(name: "Cancel", imageName: "cancel")
        ]
    }()
    
    override init() {
        super.init()
        
        self.collectionView.register(SettingCell.self, forCellWithReuseIdentifier: Constants.identifierCell)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func showSetting() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }) { (completed: Bool) in
            if setting.name != "" && setting.name != "Cancel" {
                self.homeController?.showControllerForSettings(setting: setting)
            }
        }
    }
}

extension SettingLauncher: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifierCell, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
}

extension SettingLauncher: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss(setting: settings[indexPath.item])
    }
    
}
