//
//  AppCoordinator.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

final class AppCoordinator { 
    
//    enum Strings: String, StringLocalizable {
//        var tableName: String {
//            return "AppCoordinator"
//        }
//        
//        case qrScan
//        case createQR
//        case createPhoto
//        case moveAndZoom
//        case settings
//        case cropImage
//    }
// 
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    public func start() {
        self.presentRootViewController()
//        self.presentHomeViewController()
    }
    
    private func presentRootViewController() {
        let presentationModel = RootViewPresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        
        let rootViewController = MainViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel)
        rootViewController.handler = { [weak self] event in
            switch event {
            case .home:
                break
//                self?.presentHomeViewController()
            case .fire:
                break
            case .person:
                break
//                self?.presentPesronViewController()
            case .youtube: 
                break
            }
        }
        self.navigationController.pushViewController(rootViewController, animated: false)
    }
    
    private func presentHomeViewController() {
        let presentationModel = HomePresentationModel()
        let homeControllerModel = HomeControllerModel()
        let homeViewModel = HomeViewModel()
        let dataSource = HomeDataSource(viewModel: presentationModel)
        
        let layout = UICollectionViewFlowLayout()
    
        let homeViewController = HomeViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel, uiCollectionViewLayout: layout, dataSource: dataSource)
        
        homeViewController.title = ""
        self.navigationController.pushViewController(homeViewController, animated: false)
    }
    
//    func presentPesronViewController() {
//        let presentationModel = HomePresentationModel()
//        let homeControllerModel = HomeControllerModel()
//        let homeViewModel = HomeViewModel()
//        let dataSource = HomeDataSource(viewModel: presentationModel)
//        
//        let layout = UICollectionViewFlowLayout()
//        
//        let presentationViewController = PersonViewController(presentationModel: presentationModel, viewModel: homeViewModel, model: homeControllerModel, uiCollectionViewLayout: layout, dataSource: dataSource)
//        self.navigationController.pushViewController(presentationViewController, animated: false)
//    }
}
