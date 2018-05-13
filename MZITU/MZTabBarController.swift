//
//  MZTabBarController.swift
//  MZITU
//
//  Created by mark on 2018/5/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildVc()
        
        let tabbar = MZTabBar()
        self.setValue(tabbar, forKeyPath: "tabBar")
        tabbar.addBtnActionClosure = {
            self.tabBarAddBtnAction()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChildVc() -> Void {
        self.setupChildVc(MZNewViewController(), title: "最新", normalImage: "new", selectedImage: "new_active")
        self.setupChildVc(MZRecommendViewController(), title: "推荐", normalImage: "like", selectedImage: "like_active")
//        self.setupChildVc(MZSearchViewController(), title: "搜索", normalImage: "logo", selectedImage: "logo")
        self.setupChildVc(MZHotViewController(), title: "排行", normalImage: "good", selectedImage: "good_active")
        self.setupChildVc(MZSelfieViewController(), title: "自拍", normalImage: "camera", selectedImage: "camera_active")
    }
    
    func setupChildVc(_ vc:UIViewController, title:String, normalImage:String, selectedImage:String) {
        vc.tabBarItem.image = UIImage.init(named: normalImage)
        vc.navigationItem.title = title
        vc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)
        let nav = MZNavigationController(rootViewController: vc)
        self.addChildViewController(nav)
        
    }
    func tabBarAddBtnAction() {
        let vc = MZSearchViewController.init(nibName: "MZSearchViewController", bundle: nil)
        vc.navigationItem.title = "搜索"
        let nav = MZNavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }

}
