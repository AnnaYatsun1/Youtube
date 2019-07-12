//
//  BaseCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 06/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class  BaseCell: UICollectionViewCell {
    
    //MARK: -
    //MARK: Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    } 

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    // MARK:  Public
    
    public func setupViews() {
        
    }
}
