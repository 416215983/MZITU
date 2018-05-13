//
//  MZString.swift
//  MZITU
//
//  Created by 熊猫传媒 on 2018/5/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

let regex = "(http[^\\s]+(jpg|jpeg|png|tiff)\\b)"

extension String {
    
    public func matchesForRegex(regex: String) -> Array<String> {
   
        let regularExpression = try! NSRegularExpression(pattern: regex, options: [])
        let range = NSMakeRange(0, self.count)
        let results = regularExpression.matches(in: self, options: [], range: range)
        let string = self as NSString
        var imageUrlArray = [String]()
        for reg in results {
            let url = string.substring(with: reg.range)
            imageUrlArray.append(url)
        }
        return imageUrlArray
        
    }
}
