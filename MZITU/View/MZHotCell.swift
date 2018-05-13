//
//  MZHotCell.swift
//  MZITU
//
//  Created by mark on 2018/5/9.
//  Copyright © 2018年 Mark. All rights reserved.
//

import UIKit

class MZHotCell: UICollectionViewCell {

    @IBOutlet weak var MZ_pageButton: UIButton!
    @IBOutlet weak var MZ_imageView: UIImageView!
    @IBOutlet weak var MZ_titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.MZ_pageButton.layer.cornerRadius = 10
    }

}
