//
//  BaseCell.swift
//  Youth App
//
//  Created by Thuan Tran on 3/25/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
