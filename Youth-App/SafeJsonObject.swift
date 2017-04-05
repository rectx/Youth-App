//
//  SafeJsonObject.swift
//  Youth-App
//
//  Created by Thuan Tran on 4/5/17.
//  Copyright © 2017 Thuan Tran. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        //        let range = key.startIndex...key.characters.index(key.startIndex, offsetBy: 0)
        //        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)

    }
}
