//
//  MZNetworkURL.swift
//  MZITU
//
//  Created by 熊猫传媒 on 2018/5/9.
//  Copyright © 2018年 Mark. All rights reserved.
//

import Foundation
import Alamofire
import SKPhotoBrowser

let MZ_BaseURL = "http://api.meizitu.net/wp-json/wp/v2/"

class MZNetwork{

    class func mz_loadDetailImageData(id:Int, vc:UIViewController) -> Void {
        let url = "\(MZ_BaseURL)post"
        let parameters:Parameters = ["id":id]
        var images = [SKPhoto]()
        Alamofire.request(url, method:.get, parameters:parameters).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let value = response.result.value as! NSDictionary
                    let content = value["content"] as! String
                    let urls = content.matchesForRegex(regex: regex)
                    for url in urls {
                        let photo = SKPhoto.photoWithImageURL(url)
                        images.append(photo)
                    }
                    let browser = SKPhotoBrowser(photos: images)
                    browser.initializePageIndex(0)
                    vc.present(browser, animated: true, completion: nil)
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                break
            }
        }
    }
}

