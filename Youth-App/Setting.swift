//
//  Setting.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/1/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
