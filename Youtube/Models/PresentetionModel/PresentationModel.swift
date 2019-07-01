//
//  PresentationModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 28/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit

protocol PresentationModel { // отвечает за верстку
    
    func prepareConstraints()
    func prepareLayout()
    func prepareStyle()
}

class HomePresentationModel: PresentationModel {
    public let titles = ["YouTube", "Tranding", "Subscription", "Account"]
    public let menuBar = MenuBarView()
    public let redView = UIView()
    public var titleLable: UILabel?
    
    
    func prepareConstraints() {
        self.prepareConstraintsMenuBar()
        self.prepareConstraintsRedView()
        
//        self.menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
   
    
    func prepareLayout() {

    }
    
    func prepareStyle() {
       self.redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        self.titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: self.menuBar.frame.width, height: self.menuBar.frame.height))
        let navigationBarAppearace = UINavigationBar.appearance()
        self.titleLable?.tintColor = .white
        navigationBarAppearace.tintColor = .white
        self.titleLable?.text = self.titles.first
    }
    
    
    private func prepareConstraintsMenuBar() {
    
        self.menuBar.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)

            self.menuBar.superview.do {
                menuBar.topAnchor.constraint(equalTo: $0.safeAreaLayoutGuide.topAnchor).isActive = true
            }             
        }
    }
    
    private func prepareConstraintsRedView() {
        self.redView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)
        }
    }
}

protocol ControllerModel { // хранение стейтов, обработка стейтов, походы на сервер
    
    func configure()
}

class HomeControllerModel: ControllerModel {
    public let videoManager = VideoNetworkService()
    public let model = ArrayModel(values: [Video]())

    
    func configure() {
        self.fetchVideo()
    }
    
    private func fetchVideo () {
        self.videoManager.getVideo(self.model)
    }
}


class ViewModel<Events> { // Хроняться вьюхи, и отвечает за хендлинг ивентов с вьюхи
    var eventHandler: ((Events) -> ())?
}

enum HomeEvents {
    case presentSettings(SettingsLauncherViewController)
    case presentSearch
}

class HomeViewModel: ViewModel<HomeEvents> {
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
        let settingsViewController = SettingsLauncherViewController()
        settingsViewController.modalPresentationStyle = .overCurrentContext
        settingsViewController.modalTransitionStyle = .crossDissolve
        
        self.eventHandler?(.presentSettings(settingsViewController))
    }
    
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



class HomeDataSource: NSObject, UICollectionViewDataSource {
    
     var viewModel: HomePresentationModel?
    
    // MARK: - Initialization
    
    init(viewModel: HomePresentationModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    public func count() -> Int {
        return self.viewModel?.menuBar.cellsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indentifire = self.cellIndentifire(indexPathItem: indexPath.item)
        
        return cast(collectionView.dequeueReusableCell(withReuseIdentifier: indentifire.rawValue, for: indexPath)) ?? VerticalVideoCell()
    }
    
    private func cellIndentifire(indexPathItem: Int) -> ConstantsStringCellID {
        switch indexPathItem {
        case 1:
            return .trendingCellId
        case 2:
            return .subscriptionCellId
        default:
            return .cellId
        }
    }
}
