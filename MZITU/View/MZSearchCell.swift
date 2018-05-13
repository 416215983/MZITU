//
//  MZSearchCell.swift
//  MZITU
//
//  Created by mark on 2018/5/12.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MZSearchCell: UICollectionViewCell {
    @IBOutlet weak var mz_searchImageView: UIImageView!
    
    @IBOutlet weak var mz_searchTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mz_searchImageView.layer.cornerRadius = mz_searchImageView.width * 0.5
        // Initialization code
    }

}
