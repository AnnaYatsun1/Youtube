//
//  SettingsLauncherViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 27/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

class  SettingsLauncherViewController: UIViewController {
    
    public let model: ModelSettingsLauncherState? = nil
    
    public var settingsMenuView: SettingsLauncherView {
        let settings = SettingsLauncherView()
        settings.setupSettingMenu()
        
        return settings
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(settingsMenuView) // вынести
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.onTap))
        self.view.addGestureRecognizer(gesture)
        
        self.prepareSettingsEventsHandler()
    }
    
    private func prepareSettingsEventsHandler() {
        self.settingsMenuView.settingsViewEventHandler = { [weak self] event in
            switch event {
            default:
                break
            }
        }
    }
  
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil) { // onTap не понятное название
        self.dismiss(animated: true)
    }
}

