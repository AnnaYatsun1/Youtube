//
//  SettingsLauncherCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 22/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit

class SettingsLauncherCell: BaseCell {
    
    // MARK:
    // MARK:  Accessors
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Settings"
        lable.font = .systemFont(ofSize: 13)
        return lable
    }()
    
    let settingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.darkGray
            return image
    }()
    
    public var settingsState: ModelSettingsLauncherState?

    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor =  isHighlighted ? UIColor.darkGray : UIColor.white
            self.nameLable.textColor = isHighlighted ? UIColor.white : UIColor.black
            self.settingImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    // MARK:
    // MARK:  LifeCycle
    override func setupViews() {
        super.setupViews()
        addSubview(self.nameLable)
        addSubview(self.settingImage)
        self.nameLable.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(28)
            maker.top.bottom.equalToSuperview()
        }

        self.settingImage.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
        }
    }
    
    func fill(setting: ModelSettingsLauncherState) {
        self.nameLable.text = setting.settingModel?.name
        setting.settingModel.do {
            self.settingImage.image = UIImage(named: $0.imageName)
        }
        self.settingsState = setting
        
        
        (self.settingsState?.state).do {
            switch $0 {
            case .settings:
                break
            case .help:
                break
            default:
                break 
            }
        }

    }
}

//
//settings
//help
//cancel
//feedback
//switch_account
