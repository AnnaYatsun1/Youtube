//
//  AppCoordinator.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
final class AppCoordinator { 
    
    let navigationController: UINavigationController
    let mainViewController: MainViewController
    
    init() {
        let presentationModel = RootViewPresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        
        self.mainViewController = MainViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel)
        
        self.mainViewController.modalPresentationStyle = .none
        self.navigationController = UINavigationController(rootViewController: self.mainViewController)
    }
    
    public func start() {
        self.presentRootViewController()
    }


    private func presentRootViewController() {
        self.mainViewController.handler = { [weak self] event in
            switch event {
            case .home:
                self?.presentHomeViewController()
            case .fire:
                self?.presentHomeViewController()
            case .person:
                self?.presentPesronViewController()
            case .youtube: 
                self?.presentSubscriptionViewController()
            }
        }
    }
    
    private func presentHomeViewController() {
        let presentationModel = HomePresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        let dataSource = HomeDataSource(viewModel: presentationModel)
        
        let layout = UICollectionViewFlowLayout()
        
        let homeViewController = HomeViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel, uiCollectionViewLayout: layout, dataSource: dataSource)        
    
        homeViewController.title = ""
        self.addChildViewController(homeViewController) 
    }
    
    func presentPesronViewController() {
        let presentationModel = HomePresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        let dataSource = HomeDataSource(viewModel: presentationModel)
        
        let layout = UICollectionViewFlowLayout()
        
        let presentationViewController = PersonViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel, uiCollectionViewLayout: layout, dataSource: dataSource)
        self.addChildViewController(presentationViewController)
    }
    
    func presentSubscriptionViewController() {
        let presentationModel = HomePresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        let dataSource = HomeDataSource(viewModel: presentationModel)
        
        let layout = UICollectionViewFlowLayout()
        
        let subscriptionViewController = SubscriptionViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel, uiCollectionViewLayout: layout, dataSource: dataSource)
        self.addChildViewController(subscriptionViewController)
        
    }
    
    private func removeChildViewControllers(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    
    }
    
    private func addChildViewController(_ controller: UICollectionViewController) {
        self.mainViewController.children.forEach { controller in
            self.removeChildViewControllers(controller: controller)
        }
        
        controller.view.frame = self.mainViewController.presentationModel.containerView.frame
        
        let view = self.mainViewController.view
        
        UIView.transition(
            with: view!,
            duration: 0.5,
            options: .allowAnimatedContent,
            animations: nil,
            completion: { _ in
                self.mainViewController.view.addSubview(controller.view)
                self.mainViewController.addChild(controller)
            })
        
        controller.didMove(toParent: self.mainViewController)
        print(self.mainViewController.children.count)
    }
}


class SettingsAppCoordinator {
    
    let navigationController: UINavigationController
    let settingsViewController: SettingsLauncherViewController
    let mainViewController: MainViewController
    
    init(controller: MainViewController, navigationController: UINavigationController ) {
        self.mainViewController = controller
        self.navigationController = navigationController
        
        self.settingsViewController = SettingsLauncherViewController()
        self.settingsViewController.modalPresentationStyle = .overCurrentContext
        self.settingsViewController.modalTransitionStyle = .crossDissolve
    }
    
    func start() {
        self.presentSettingsViewController() 
        
        self.settingsViewController.settingsMenuView.settingsViewEventHandler = { state in
            switch state {
            case .settings:
                self.presentSettingViewController()
                break
            default:
                break
            }
        }
    }
    
    func presentSettingsViewController() {
        self.navigationController.present(self.settingsViewController, animated: false)
    }
    
    func presentSettingViewController() {
        let settings = SettingsViewController()
        self.navigationController.pushViewController(settings, animated: true)
    }
}
