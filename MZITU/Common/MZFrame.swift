//
//  MZFrame.swift
//  MZITU
//
//  Created by 熊猫传媒 on 2018/5/10.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MZFrame: UIView {

}
extension UIView {
    
    var width : CGFloat {
        get{
            return self.bounds.size.width
        }
        set(width) {
            self.frame.size = CGSize(width: width, height: self.frame.height)
        }
    }
    var height : CGFloat {
        get{
            return self.bounds.size.height
        }
        set(width) {
            self.frame.size = CGSize(width: self.frame.height, height: height)
        }
    }
    
}
