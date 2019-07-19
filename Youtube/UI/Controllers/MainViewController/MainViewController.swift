//
//  MainViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class MainViewController: RootViewController <RootViewPresentationModel, HomeEvents, BaseViewModel, BasicControllerModel> {
    
    typealias RootViewEventHandler = (MenuBarViewModel.BarState) -> ()
    
    var handler: RootViewEventHandler?
    
    override func viewDidLoad() {
                
        self.view.addSubview(self.presentationModel.menuBar)
        self.view.addSubview(self.presentationModel.redView)
        self.view.addSubview(self.presentationModel.containerView)
        self.view.backgroundColor = .white
        self.viewModel.moreButton.do { moreButton in
            self.viewModel.searchBarButtonItem.do {
                self.navigationItem.rightBarButtonItems = [moreButton, $0]
            }
        }     
        
        super.viewDidLoad()        
        
        self.presentationModel.menuBar.viewModel = MenuBarViewModel() {
            self.handler?($0)    
        }
        
        self.viewModel.eventHandler = { state in 
            switch state {
            case .presentSearch:
                self.viewModel.handlerSearch()
            case .presentSettings(let settingsViewController):
                let settingsViewController = SettingsLauncherViewController()
                settingsViewController.modalPresentationStyle = .overCurrentContext
                settingsViewController.modalTransitionStyle = .crossDissolve
                
                self.navigationController.do {
                    let settingsAppCoordinator = SettingsAppCoordinator(controller: self, navigationController: $0)
                    settingsAppCoordinator.start()
                }
//                let settingsAppCoordinator = SettingsAppCoordinator(controller: self, settingsViewController: )
                
//                self.navigationController?.present(settingsViewController, animated: true, completion: nil)
                break
            }
        }
    }
}
