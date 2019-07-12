//
//  HomeViewController1.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import  UIKit
enum MainScreenEvents {
    case home
    case person
    case youtube
    case fire
}


class HomeViewController1: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel>, UICollectionViewDelegateFlowLayout {
    
    private var dataSource: HomeDataSource?
    
    override func viewDidLoad() {
        self.view.addSubview(self.presentationModel.redView)
        self.view.addSubview(self.presentationModel.menuBar)        
        
        self.viewModel.moreButton.do { moreButton in
            self.viewModel.searchBarButtonItem.do {
                self.navigationItem.rightBarButtonItems = [moreButton, $0]
            }
        }        
        
        super.viewDidLoad()
        
        self.viewModel.eventHandler = { state in 
            switch state {
            case .presentSearch:
                self.viewModel.handlerSearch()
            case .presentSettings(let settingsViewController):
                self.navigationController?.present(settingsViewController, animated: true, completion: nil)
                break
            }
        }
        
        self.presentationModel.menuBar.viewModel = MenuBarViewModel() { [weak self] in
            self?.scrollMenuIndex(menuIndex: $0.rawValue)
        }
        
        self.dataSource = HomeDataSource(viewModel: self.presentationModel)
        
        self.setupCollectionView()
        self.setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Home"
        self.navigationItem.titleView =  self.presentationModel.titleLable
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupCollectionView() {
        let collectionView = self.collectionView
        if  let layout: UICollectionViewFlowLayout = cast(self.collectionView?.collectionViewLayout) {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.do {
            $0.backgroundColor = UIColor.white
            $0.isPagingEnabled = true
            $0.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
            $0.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
            $0.dataSource = dataSource
            $0.register(VerticalVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.cellId.rawValue)
            $0.register(VerticalTrendingVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.trendingCellId.rawValue)
            $0.register(VerticalSubscriptionVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.subscriptionCellId.rawValue)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView, 
        layout collectionViewLayout: UICollectionViewLayout, 
        sizeForItemAt indexPath: IndexPath
        ) 
        -> CGSize 
    {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
    }
    
    private func scrollMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
        self.setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if  let titleLable: UILabel = cast(self.navigationItem.titleView) {
            titleLable.text = self.presentationModel.titles[index]
        }
    }
}


final class AppCoordinator { 
    typealias MainScreenEventsHandler = (MainScreenEvents) -> ()
    
    enum Strings: String, StringLocalizable {
        var tableName: String {
            return "AppCoordinator"
        }
        
        case qrScan
        case createQR
        case createPhoto
        case moveAndZoom
        case settings
        case cropImage
    }
    
    
    private let navigationController: UINavigationController
    
     init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        self.startMain()
    }
    
    private func startMain() {
        let handler: MainScreenEventsHandler = { [weak self] event in
            switch event {
            case .home:
                break
            case .fire:
                break
            case .person:
                break
            case .youtube: 
                break
                
//            case :
//                break
//            case .:
//                self?.presentQRScaner()
//            case .generateQR:
//                self?.startQRCodeGenerator(image: nil)
//            case .createImage(let image):
//                self?.startQRCodeGenerator(image: image)
//            case .settings:
//                self?.startSettings()
            }
        }
        
        let mainViewController = MainScreenViewController(eventHandler: handler)
        mainViewController.title = ""
        self.navigationController.viewControllers = [mainViewController]
    }
    }
}
