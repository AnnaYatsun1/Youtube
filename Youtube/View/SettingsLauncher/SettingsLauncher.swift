//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Anna Yatsun on 22/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let height: CGFloat = 300
    static let heightSettingsCell: CGFloat = 50
}

fileprivate struct ConstantString  {
    
    static let settings = "Settings"
    static let help = "Help"
    static let cancel = "Cancel"
    static let feedback = "Send Feedback"
    static let switchAccount  = "Switch Account"
}

class SettingsLauncher: BaseViewControllerObserver, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let settingsname = 
    [
        ConstantString.settings, 
        ConstantString.help, 
        ConstantString.cancel, 
        ConstantString.feedback, 
        ConstantString.switchAccount
    ]
    
    private let settingsIMG = 
    [
        ConstantString.settings, 
        ConstantString.help, 
        ConstantString.cancel, 
        ConstantString.feedback, 
        ConstantString.switchAccount
    ]
    
    private var layout = UICollectionViewFlowLayout()
    
    private var settings: [Setting] {        
        return zip(self.settingsname, self.settingsIMG).map { name, image in 
            Setting(name: name, imageName: image) 
        }
    }
    
    lazy fileprivate var  collectionViewSettingsMenu = UICollectionView(frame: .zero, collectionViewLayout: layout)
    lazy fileprivate var tapInterceptView: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tap.delegate = self
        
        return tap
    }()

    //MARK: -
    //MARK: Initializations 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        collectionViewSettingsMenu.delegate = self
        collectionViewSettingsMenu.dataSource = self
        collectionViewSettingsMenu.register(SettingsLauncherCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK:
    // MARK:  Public
    
    public func setupSettingMenu()  {
      if let windows = UIApplication.shared.keyWindow {
            self.backgroundColor = .white
            windows.addSubview(self)
            
            self.frame = CGRect(x: 0, 
                                y: 0, 
                                width: UIScreen.main.bounds.width, 
                                height: UIScreen.main.bounds.height)
            self.alpha = 0.2
            windows.addSubview(collectionViewSettingsMenu)
            
            self.collectionViewSettingsMenu.backgroundColor = .white
            self.collectionViewSettingsMenu.frame = CGRect(x: windows.frame.minX, 
                                                           y: windows.frame.height, 
                                                           width: windows.frame.width, 
                                                           height: Constant.height)
            UIView.animate(
                withDuration: 0.5, 
                delay: 0, 
                options: .curveEaseOut, 
                animations: {
                    self.collectionViewSettingsMenu.frame = CGRect(x: windows.frame.minX,
                                                                   y: windows.frame.height - Constant.height,
                                                                   width: self.collectionViewSettingsMenu.frame.width, 
                                                                   height: self.collectionViewSettingsMenu.frame.height)
                    self.collectionViewSettingsMenu.alpha = 1
                }
            )
        }
    }
    
    @objc internal func tap(_ sender: UITapGestureRecognizer?) {
        self.hideSetingsMenu()
    }
    
    // MARK:
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SettingsLauncherCell
        let settings = self.settings[indexPath.row]
        cell.nameLable.text = settings.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewSettingsMenu.frame.width, height: Constant.heightSettingsCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let settings = self.settings[indexPath.row]

        self.hideSetingsMenu {
            switch  settings.name {
                case ConstantString.settings: 
                    self.moveToSettings()
                case ConstantString.help: 
                    self.moveToHelp()
                case ConstantString.cancel:
                    self.hideSetingsMenu()
                case ConstantString.feedback:
                    break
                case ConstantString.switchAccount:
                    break
                default:
                    break
                }
        }
    }
    
    // MARK:
    // MARK:  Private
    
    private func hideSetingsMenu(completion: (() -> ())? = nil) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0, 
            options: .curveEaseOut, 
            animations: {
                if let windows = UIApplication.shared.keyWindow {
                    self.collectionViewSettingsMenu.frame = CGRect(x: windows.frame.minX, 
                                                                   y: windows.frame.height - Constant.height, 
                                                                   width: self.collectionViewSettingsMenu.frame.width, 
                                                                   height: self.collectionViewSettingsMenu.frame.height)
                    self.alpha = 0
                    self.collectionViewSettingsMenu.alpha = 0
                    completion?()
                }
            }
        )
    }
    
    private func setupSubviews() {
        self.addGestureRecognizer(tapInterceptView)
        self.addSubview(collectionViewSettingsMenu)
        self.addGestureRecognizer(tapInterceptView)
    }
}
