//
//  MenuCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 06/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    // MARK:
    // MARK:  Accessors
    
    let imagesView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        iv.image = UIImage(named: "homes")?.withRenderingMode(.alwaysTemplate)
        
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            self.imagesView.tintColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.imagesView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    // MARK:
    // MARK:  View Life Cycle
    
    override func setupViews() {
        super.setupViews()
        addSubview(self.imagesView)
        
        self.imagesView.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(28)
            maker.centerY.centerX.equalToSuperview()
        }
        
    }
    
    func fill(menuBar: MenuBarModel) {
        self.imagesView.image = UIImage(named: menuBar.menuBarIcon)?.withRenderingMode(.alwaysTemplate)
    }
}
