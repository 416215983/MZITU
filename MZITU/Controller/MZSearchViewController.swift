//
//  MZSearchViewController.swift
//  MZITU
//
//  Created by mark on 2018/5/8.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

let MZSearchCellIdentifier = "MZSearchCellIdentifier"
class MZSearchViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let closeItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(closeVc))
        navigationItem.leftBarButtonItems = [closeItem]
        
        flowLayout.itemSize = CGSize(width: self.view.width / 4, height: self.view.width / 4)
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(UINib.init(nibName: "MZSearchCell", bundle: nil), forCellWithReuseIdentifier: MZSearchCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MZSearchCellIdentifier, for: indexPath) as! MZSearchCell
        cell.mz_searchTitleLabel.text = self.arrTitle[indexPath.row]
        cell.mz_searchImageView.image = UIImage.init(named: self.arrImage[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchStr = self.arrTitle[indexPath.row]
        let vc = MZSearchResultViewController()
        vc.searchStr = searchStr
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = MZSearchResultViewController()
        vc.searchStr = searchBar.text
        navigationController?.pushViewController(vc, animated: true)
    }

    
    //清纯 诱惑 走光 爆乳 翘臀 美腿 制服 黑丝
    lazy var arrTitle = ["清纯","诱惑","走光","爆乳","翘臀","美腿","制服","黑丝"]
    lazy var arrImage = ["qingchun","youhuo","zouguang","baoru","meitun","meitui","zhifu","heisi"]
    
    @objc func closeVc() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
