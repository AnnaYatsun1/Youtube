//
//  ViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/03/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher 

fileprivate struct Constants {
    static let constatn:CGFloat = 32
    static let constatnWidth: CGFloat = 50
}

fileprivate enum ConstantsStringCellID: String  {
    case trendingCellId
    case subscriptionCellId
    case cellId
} 

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK:
    // MARK:  Accessors
    public let observeringModel = CancellableObject()
    public let observering = CancellableObject()
    public let settingsMenu = SettingsLauncher()
    public let settings = SettingsLauncher()
    public let menuBar = MenuBar()
    public let redView = UIView()
    public let videoManager = VideoNetworkService()

    private lazy var height = self.view.frame.width - Constants.constatn
    private let titles = ["YouTube", "Tranding", "Subscription", "Account"]
    private let model = ArrayModel(values: [Video]())
 
    // MARK:
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMenuBer()
        self.setupNavBarButtons()
        self.redirectToNewController()
        self.setupCollectionView()
        self.setupNavigationItem()
        self.scrollMenuBar()
    }

    // MARK:
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuBar.CellsCount     
    }
    
    override func collectionView(
        _ collectionView: UICollectionView, 
        cellForItemAt cellForItemAtindexPath: IndexPath
    )
        -> UICollectionViewCell 
    {
        let indentifire = self.cellIndentifire(indexPathItem: cellForItemAtindexPath.item)
        
        return cast(collectionView.dequeueReusableCell(withReuseIdentifier: indentifire.rawValue, for: cellForItemAtindexPath)) ?? VerticalVideoCell()
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let count = CGFloat(self.menuBar.CellsCount)
        self.menuBar.horizontalView.frame.origin.x = scrollView.contentOffset.x / count
    }
    
    override func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint, 
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let index = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: index, section: 0) 
        self.menuBar.collectionView.selectItem(at: indexPath, animated:true, scrollPosition: .centeredHorizontally)
        self.setTitleForIndex(index: index)
    }
        
    // MARK:
    // MARK:  Private
    
  private  func redirectToNewController() {
        // can replace for Coordinator
        self.observering.value = self.settingsMenu.observer.observer { menuState, _ in 
            switch menuState {
            case .settings: 
               self.moveToSettingsController()
            case .help: 
                self.moveToHelpController()
            default: 
                break
            }
        }
    }
    
    private func moveToHelpController() {
        let helpViewController = HelpViewController()
        self.navigationController?.pushViewController(helpViewController, animated: true)
    }
    
    private func moveToSettingsController() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    private func setupMenuBer() {
        self.redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        self.view.addSubview(self.redView)
        
        self.redView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)
        }
            
        self.view.addSubview(self.menuBar)
        self.menuBar.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.width.height.equalTo(50)
        }
        
        self.menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupNavBarButtons() {
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handlerMore))
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handlerSerch))
        searchBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
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
            $0.register(VerticalVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.cellId.rawValue)
            $0.register(VerticalTrendingVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.trendingCellId.rawValue)
            $0.register(VerticalSubscriptionVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.subscriptionCellId.rawValue)
        }
    }
    
    private func setupNavigationItem() {
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        let navigationBarAppearace = UINavigationBar.appearance()
        titleLable.tintColor = .white
        navigationBarAppearace.tintColor = .white
        titleLable.text = self.titles.first
     
        self.navigationItem.title = "Home"
        self.navigationItem.titleView = titleLable
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
    }
     
    private func scrollMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
        self.setTitleForIndex(index: menuIndex)
    }
    
    private func scrollMenuBar() {
        self.menuBar.observer.observer { menuBarStatus, _ in 
            switch menuBarStatus {
            case .home:
                self.scrollMenuIndex(menuIndex: 0)
            case .person:
                self.scrollMenuIndex(menuIndex: 1)
            case .fire:
                self.scrollMenuIndex(menuIndex: 3)
            case .youtube:
                self.scrollMenuIndex(menuIndex: 2)
            }
        }
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
    
    private func setTitleForIndex(index: Int) {
        if  let titleLable: UILabel = cast(self.navigationItem.titleView) {
            titleLable.text = self.titles[index]
        }
    }
        
    @objc func handlerMore() {
        self.settingsMenu.setupSettingMenu()
    }
    
    @objc func handlerSerch() { 
//        self.scrollMenuIndex(menuIndex: 3)
    }
}
