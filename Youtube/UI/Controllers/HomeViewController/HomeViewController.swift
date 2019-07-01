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

enum ConstantsStringCellID: String  {
    case trendingCellId
    case subscriptionCellId
    case cellId
} 


//protocol ControllerModel { // хранение стейтов, обработка стейтов, походы на сервер
//    
//    func configure()
//}

//class ViewModel<Events> { // Хроняться вьюхи, и отвечает за хендлинг ивентов с вьюхи
//    
//    var eventHandler: ((Events) -> ())?
//}

class ViewController<PresentationViewModel: PresentationModel, Events, ViewModelType: ViewModel<Events>, Model: ControllerModel>: UICollectionViewController {

    // отвечает за навигацию, и вызова моделей
    
    let presentationModel: PresentationViewModel
    let viewModel: ViewModelType
    let model: Model
    
    init(presentationModel: PresentationViewModel, viewModel: ViewModelType, model: Model, uiCollectionViewLayout: UICollectionViewLayout) {
        self.presentationModel = presentationModel
        self.viewModel = viewModel
        self.model = model
        
        super.init(collectionViewLayout: uiCollectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.configure()
        self.presentationModel.prepareLayout()
        self.presentationModel.prepareStyle()
        self.presentationModel.prepareConstraints()
    }
}

//class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout { // отнаследовать от ViewController и унести верстку в перезнтационную модель
//
//    // MARK:
//    // MARK:  Accessors
//    
//    public let observeringModel = CancellableObject()
//    public let observering = CancellableObject()
//    public let settingsMenu = SettingsLauncherView()
//    public let settings = SettingsLauncherView()
//    public var menuBar = MenuBarView()
//
//    public let redView = UIView()
//    public let videoManager = VideoNetworkService()
//    public let modelSettingsLauncherState = ModelSettingsLauncherState(state: .settings)
//
//    private lazy var height = self.view.frame.width - Constants.constatn
//    private let titles = ["YouTube", "Tranding", "Subscription", "Account"]
//    private let model = ArrayModel(values: [Video]())
// 
//    // MARK:
//    // MARK:  View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setupMenuBarView()
//        self.setupNavBarButtons()
////        self.redirectToNewController()
//        self.setupCollectionView()
//        self.setupNavigationItem()
//    }
//
//    // MARK:
//    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.menuBar.cellsCount     
//    }
//    
//    override func collectionView(
//        _ collectionView: UICollectionView, 
//        cellForItemAt cellForItemAtindexPath: IndexPath
//    )
//        -> UICollectionViewCell 
//    {
//        let indentifire = self.cellIndentifire(indexPathItem: cellForItemAtindexPath.item)
//        
//        return cast(collectionView.dequeueReusableCell(withReuseIdentifier: indentifire.rawValue, for: cellForItemAtindexPath)) ?? VerticalVideoCell()
//    }
//        
//    func collectionView(
//        _ collectionView: UICollectionView, 
//        layout collectionViewLayout: UICollectionViewLayout, 
//        sizeForItemAt indexPath: IndexPath
//    ) 
//        -> CGSize 
//    {
//        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 50)
//    }
//    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let count = CGFloat(self.menuBar.cellsCount)
//        self.menuBar.horizontalView.frame.origin.x = scrollView.contentOffset.x / count
//    }
//    
//    override func scrollViewWillEndDragging(
//        _ scrollView: UIScrollView,
//        withVelocity velocity: CGPoint, 
//        targetContentOffset: UnsafeMutablePointer<CGPoint>
//    ) {
//        let index = Int(targetContentOffset.pointee.x / self.view.frame.width)
//        let indexPath = IndexPath(item: index, section: 0) 
//        self.menuBar.collectionView.selectItem(at: indexPath, animated:true, scrollPosition: .centeredHorizontally)
//        self.setTitleForIndex(index: index)
//    }
//        
//    // MARK:
//    // MARK:  Private
//    
//    private func setupMenuBarView() {
//        self.menuBar.viewModel = MenuBarViewModel() { [weak self] in
//            self?.scrollMenuIndex(menuIndex: $0.rawValue)
//        }
//        
//        self.redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
//        self.view.addSubview(self.redView)
//        
//        self.redView.snp.makeConstraints { (maker) in
//            maker.left.right.equalToSuperview()
//            maker.width.height.equalTo(50)
//        }
//            
//        self.view.addSubview(self.menuBar)
//        self.menuBar.snp.makeConstraints { (maker) in
//            maker.left.right.equalToSuperview()
//            maker.width.height.equalTo(50)
//        }
//        
//        self.menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
//    }
//    
//    private func setupNavBarButtons() {
//        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
//        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handlerMore))
//        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handlerSerch))
//        searchBarButtonItem.tintColor = .black
//        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
//    }
//    
//    private func setupCollectionView() {
//        let collectionView = self.collectionView
//        if  let layout: UICollectionViewFlowLayout = cast(self.collectionView?.collectionViewLayout) {
//            layout.scrollDirection = .horizontal
//            layout.minimumLineSpacing = 0
//        }
//        
//        collectionView.do {
//            $0.backgroundColor = UIColor.white
//            $0.isPagingEnabled = true
//            $0.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
//            $0.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
//            $0.register(VerticalVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.cellId.rawValue)
//            $0.register(VerticalTrendingVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.trendingCellId.rawValue)
//            $0.register(VerticalSubscriptionVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.subscriptionCellId.rawValue)
//        }
//    }
//    
//    private func setupNavigationItem() {
//        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        let navigationBarAppearace = UINavigationBar.appearance()
//        titleLable.tintColor = .white
//        navigationBarAppearace.tintColor = .white
//        titleLable.text = self.titles.first
//     
//        self.navigationItem.title = "Home"
//        self.navigationItem.titleView = titleLable
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.hidesBarsOnSwipe = true
//    }
//     
//    private func scrollMenuIndex(menuIndex: Int) {
//        let indexPath = IndexPath(row: menuIndex, section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
//        self.setTitleForIndex(index: menuIndex)
//    }
//
//    private func cellIndentifire(indexPathItem: Int) -> ConstantsStringCellID {
//        switch indexPathItem {
//        case 1:
//            return .trendingCellId
//        case 2:
//            return .subscriptionCellId
//        default:
//            return .cellId
//        }
//    }
//    
//    private func setTitleForIndex(index: Int) {
//        if  let titleLable: UILabel = cast(self.navigationItem.titleView) {
//            titleLable.text = self.titles[index]
//        }
//    }
//        
//    @objc func handlerMore() {
//        let settingsViewController = SettingsLauncherViewController()
//        settingsViewController.modalPresentationStyle = .overCurrentContext
//        settingsViewController.modalTransitionStyle = .crossDissolve
//        
//        self.navigationController?.present(settingsViewController, animated: true, completion: nil)
//    }
//    
//    @objc func handlerSerch() { 
//
//    }
//}
//
