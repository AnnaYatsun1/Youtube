//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Anna Yatsun on 22/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

enum EventMenuState: Int {
    
    case settings
    case help
    case cancel
    case feedback
    case switch_account
}

class  ModelSettingsLauncherState {
    
    private let settingsname = 
        [
            ConstantString.settings, 
            ConstantString.help, 
            ConstantString.cancel, 
            ConstantString.feedback, 
            ConstantString.switchAccount
        ]
    
    private let settingsImage = 
        [
            ConstantString.settings, 
            ConstantString.help, 
            ConstantString.cancel, 
            ConstantString.feedback, 
            ConstantString.switchAccount
        ]
    
    private var settings: [SettingModel] {
        return zip(self.settingsname, self.settingsImage).map { name, image in 
            SettingModel(name: name, imageName: image) 
        }
    }
  
    //MARK: -
    //MARK: Variables
    
    var state: EventMenuState
    var settingModel: SettingModel?
    
    //MARK: -
    //MARK: Initializations
    
    init(state: EventMenuState) {
        self.state = state
        self.settingModel = self.settings[state.rawValue]
    }
}

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

class SettingsLauncherView: UIView, UIGestureRecognizerDelegate {
    
    private var states = [ModelSettingsLauncherState]()
    private var layout = UICollectionViewFlowLayout()
    
    var settingsViewEventHandler: ((EventMenuState) -> ())?
    
    lazy fileprivate var collectionViewSettingsMenu = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        
        [.cancel, .help, .feedback, .switch_account, .settings].forEach {
            self.states.append(.init(state: $0))
        }
        
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
        self.frame = CGRect(
            x: 0, 
            y: UIScreen.main.bounds.height - Constant.height, 
            width: UIScreen.main.bounds.width, 
            height: Constant.height
        )
        
        self.collectionViewSettingsMenu.backgroundColor = .white
        self.collectionViewSettingsMenu.frame = CGRect(
            x: self.frame.minX, 
            y: UIScreen.main.bounds.height - Constant.height, 
            width: self.frame.width, 
            height: Constant.height
        )
        
        UIView.animate(
            withDuration: 0.5, 
            delay: 0, 
            options: .curveEaseOut, 
            animations: {
                self.collectionViewSettingsMenu.frame = CGRect(x: self.frame.minX,
                                                               y: self.frame.height - Constant.height,
                                                               width: self.collectionViewSettingsMenu.frame.width, 
                                                               height: self.collectionViewSettingsMenu.frame.height)
                self.collectionViewSettingsMenu.alpha = 1
            }
        )
    }
    
    @objc internal func tap(_ sender: UITapGestureRecognizer?) {

    }

    // MARK:
    // MARK:  Private
    
    private func setupSubviews() {
        self.addGestureRecognizer(tapInterceptView)
        self.addSubview(collectionViewSettingsMenu)
        self.addGestureRecognizer(tapInterceptView)
    }
}


// MARK:
// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension SettingsLauncherView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.states.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cast(collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)) ?? SettingsLauncherCell()
        let settings = self.states[indexPath.row]
        cell.fill(setting: settings)
    
        return cell
    }   

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let state = self.states[indexPath.row].state
        self.settingsViewEventHandler?(state)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewSettingsMenu.frame.width, height: Constant.heightSettingsCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
