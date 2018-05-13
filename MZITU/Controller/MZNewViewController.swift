//
//  MZNewViewController.swift
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

let MZNewCellIdentifier = "MZNewCellIdentifier"
let Margin:CGFloat = 10
class MZNewViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SKPhotoBrowserDelegate {

    var collectionView:UICollectionView!
    var flowLayout:UICollectionViewFlowLayout!
    var newArr = [MZModel]()
    var page:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.hidesBarsOnSwipe = true
        flowLayout = UICollectionViewFlowLayout.init()
        let width = self.view.width - 2 * Margin
        let height = width * 1.65
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = UIEdgeInsets(top: Margin, left: 0, bottom: Margin, right: 0)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        self.view.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: "MZHotCell", bundle: nil), forCellWithReuseIdentifier: MZNewCellIdentifier)

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MZNewCellIdentifier, for: indexPath) as! MZHotCell
        let model:MZModel = self.newArr[indexPath.row]
        cell.MZ_pageButton.setTitle(model.img_num!, for: .normal)
        cell.MZ_imageView.kf.setImage(with: URL(string: model.thumb_src!))
        cell.MZ_titleLabel.text = model.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model:MZModel = self.newArr[indexPath.row]
        MZNetwork.mz_loadDetailImageData(id: model.id!, vc: self)
    }
    
    func loadData() {
        let url = "\(MZ_BaseURL)posts"
        let parameters:Parameters = ["per_page":"5","page":1]
        Alamofire.request(url,parameters:parameters).responseJSON {[unowned self] (response) in
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
    @objc func loadMoreData() {
        let url = "\(MZ_BaseURL)posts"
        let parameters:Parameters = ["per_page":"5","page":page]
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
    deinit {
        self.collectionView.es.removeRefreshHeader()
        self.collectionView.es.removeRefreshFooter()
    }
}
