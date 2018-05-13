//
//  MZTabBar.swift
//  MZITU
//
//  Created by 熊猫传媒 on 2018/5/9.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MZTabBar: UITabBar {

    var addBtnActionClosure:(()->Void)?
    var addBtn:UIButton?
    var bottomOffSet:CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
//        self.shadowImage = UIImage.init(cgImage: UIColor.clear as! CGImage)
        addBtn = UIButton.init(type: .custom)
        addBtn?.setBackgroundImage(UIImage.init(named: "logo"), for: .normal)
        addBtn?.setBackgroundImage(UIImage.init(named: "logo"), for: .selected)
        addBtn?.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        addBtn?.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        self.addSubview(addBtn!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let className:AnyClass = NSClassFromString("UITabBarButton")!
        addBtn?.center.x = self.center.x
        addBtn?.center.y = self.frame.size.height * 0.5 - 2.0 * bottomOffSet
        addBtn?.frame.size = CGSize(width: addBtn!.currentBackgroundImage!.size.width, height: addBtn!.currentBackgroundImage!.size.height)
        var btnIndex:CGFloat = 0
        for btn in self.subviews {
            if btn.isKind(of: className) {
                btn.frame.size.width = self.frame.size.width / 5
                btn.frame.origin.x = btn.frame.size.width * btnIndex
                btnIndex += 1
                if btnIndex == 2 {
                    btnIndex += 1
                }
            }
            
        }
        self.bringSubview(toFront: addBtn!)
        
    }
    
    
    @objc func addBtnClick() {
        if let action = addBtnActionClosure {
            action()
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let newPoint = self.convert(point, to: addBtn)
        if let addBtn = self.addBtn{
            if addBtn.point(inside: newPoint, with: event) {
                return self.addBtn
            }
        }
        return super.hitTest(point, with: event)
        
        
        
    }
}
