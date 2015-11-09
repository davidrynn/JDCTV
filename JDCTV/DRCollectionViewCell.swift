//
//  DRCollectionViewCell.swift
//  JDCSwiftTV
//
//  Created by David Rynn on 11/7/15.
//  Copyright © 2015 David Rynn. All rights reserved.
//

import UIKit

class DRCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: frame)
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        super.init(frame: frame)
        contentView.addSubview(imageView)
  
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    

    
}
