//
//  MZSelfieViewController.swift
//  MZITU
//
//  Created by mark on 2018/5/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import SKPhotoBrowser
import Kingfisher
import ESPullToRefresh

let MZSelfieCellIdentifier = "MZSelfieCellIdentifier"

class MZSelfieViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView:UICollectionView!
    var flowLayout:UICollectionViewFlowLayout!
    var newArr = [MZModel]()
    var page:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout = UICollectionViewFlowLayout.init()
        let width = (self.view.width - 4 * Margin) / 3
        let height = width
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = UIEdgeInsets(top: Margin, left: Margin, bottom: Margin, right: Margin)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.headerReferenceSize = CGSize(width: self.view.width, height: 30)
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: "MZSelfieCell", bundle: nil), forCellWithReuseIdentifier: MZSelfieCellIdentifier)
        
        self.edgesForExtendedLayout = []
        collectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        
        weak var wself = self
        collectionView.es.addPullToRefresh {
            wself?.loadData()
        }
        collectionView.es.startPullToRefresh()
        collectionView.es.addInfiniteScrolling {
            wself?.loadMoreData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if newArr.count>0 {
            return newArr.count
        }else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MZSelfieCellIdentifier, for: indexPath) as! MZSelfieCell
        let model:MZModel = self.newArr[indexPath.row]
        cell.mz_imageView.kf.setImage(with: URL(string: model.thumb_src!))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model:MZModel = self.newArr[indexPath.row]
        let browser = SKPhotoBrowser(photos: [SKPhoto.photoWithImageURL(model.img_src!)], initialPageIndex: indexPath.row)
        self.present(browser, animated: true, completion: nil)
    }
    
    
    func loadData() {
        //post=3238&per_page=45
        let url = "\(MZ_BaseURL)comments"
        let parameters:Parameters = ["post":3238,"per_page":45,"page":1]
        Alamofire.request(url,parameters:parameters).responseJSON { (response) in
            self.collectionView.es.stopPullToRefresh()
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    self.page = 2
                    let value = response.result.value as! NSArray
                    let model = JSONDeserializer<MZModel>.deserializeModelArrayFrom(array: value)
                    self.newArr = model as! [MZModel]
                    self.collectionView.reloadData()
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                break
            }
        }
    }
    func loadMoreData() {
        let url = "\(MZ_BaseURL)comments"
        let parameters:Parameters = ["post":3238,"per_page":45,"page":page]
        Alamofire.request(url,parameters:parameters).responseJSON { (response) in
            self.collectionView.es.stopLoadingMore()
            switch(response.result) {
            case .success(_):
                let value = response.result.value as AnyObject
                if value.isKind(of: NSArray.self){
                    let model = JSONDeserializer<MZModel>.deserializeModelArrayFrom(array: (value as! Array))
                    for m in model! {
                        self.newArr.append(m!)
                    }
                    self.collectionView.reloadData()
                }else {
                    self.collectionView.es.noticeNoMoreData()
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                break
            }
        }
    }
    
    func loadDetailData(id:Int) {
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
                    self.present(browser, animated: true, completion: nil)
                }
                break
            case .failure(_):
                print("Failure : \(response.result.error!)")
                break
            }
        }
    }
    deinit {
        self.collectionView.es.removeRefreshHeader()
        self.collectionView.es.removeRefreshFooter()
    }

}
