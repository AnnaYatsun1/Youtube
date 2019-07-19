//
//  HomeViewModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

enum HomeEvents {
    case presentSettings(SettingsLauncherViewController)
    case presentSearch
}

class BaseViewModel: ViewModel<HomeEvents>  {
    
    var moreButton: UIBarButtonItem?
    var searchBarButtonItem: UIBarButtonItem?
    
    override init() {
        super.init()
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton =  UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handlerMore))
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handlerSearch))
        self.moreButton = moreButton
        self.searchBarButtonItem = searchBarButtonItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlerSearch() {
        
    }
    
    @objc func handlerMore() {
//        let settingsAppCoordinator = SettingsAppCoordinator()
//        settingsAppCoordinator.start()
        
        let settingsViewController = SettingsLauncherViewController()
        settingsViewController.modalPresentationStyle = .overCurrentContext
        settingsViewController.modalTransitionStyle = .crossDissolve
        self.eventHandler?(.presentSettings(settingsViewController))
    }
}


class HomeViewModel: BaseViewModel {
    
}

class Subscriprions: BaseViewModel {
    
}

class Trending: BaseViewModel {
    
}
