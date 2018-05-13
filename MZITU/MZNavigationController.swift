//
//  MZNavigationController.swift
//  MZITU
//
//  Created by mark on 2018/5/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit


class MZNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        let navigationBar = UINavigationBar.appearance()
        navigationBar.isTranslucent = false
//        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.barTintColor = UIColor.init(red: 249/255, green: 156/255, blue: 187/255, alpha: 1.0)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.shadowImage = UIImage()
        self.hidesBarsOnSwipe = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let closeItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(closeVc))
            viewController.navigationItem.leftBarButtonItems = [closeItem]
        }
        super.pushViewController(viewController, animated: true)
    }
    @objc func closeVc() {
        self.popViewController(animated: true)
    }
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if self.childViewControllers.count == 1 {return false}
//        return self.childViewControllers.count > 1
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
