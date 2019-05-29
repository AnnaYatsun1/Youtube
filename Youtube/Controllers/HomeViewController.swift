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
class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK:
    // MARK:  Accessors
    public let observeringModel = CancellableObject()
    public let observering = CancellableObject()
    public let settingsMenu = SettingsLauncher()
    public let settings = SettingsLauncher()
    public let menuBar = MenuBar()
    public let redView = UIView()
    
    public var videoManager = VideoNetworkService()
    
    private let model = ArrayModel(values: [Video]())
    
    private lazy var height = self.view.frame.width - Constants.constatn
 
    // MARK:
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observeringModel.value = self.model.observer { state, _ in 
            switch state {
            case .add: self.update()
            case .remove: break
            case .update: self.update()
            }
        }        
     
        self.setupMenuBer()
        self.setupNavBarButtons()
        self.fetchVideo()
        self.redirectToNewController()
        self.setupCollectionView()
        self.setupNavigationItem()
    }
    
    // MARK:
    // MARK:  Public
    func update() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        } 
    }

    func fetchVideo () {
        self.videoManager.getVideo(self.model) { _ in 
            print()
        }
    }

    // MARK:
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4     
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt cellForItemAtindexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: cellForItemAtindexPath) as! UICollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.model.count        
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt cellForItemAtindexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: cellForItemAtindexPath) as! VideoCell
//        
//        let video = self.model[cellForItemAtindexPath.row]
//        cell.titleLable.text = video.value.title
//        let urlString = video.value.tubnnailImageName 
//        let url = URL(string: urlString)
//        let placeholder = Image(named: "placeholder")
//        cell.thumbnailImageView.kf.setImage(with: url, placeholder: placeholder)
//        
//        let userProfileImage = video.value.channel.profileImageName
//        let urlImageProfile = URL(string: userProfileImage)
//        cell.userProfileImageView.kf.setImage(with: urlImageProfile)
//        
//        let formater = NumberFormatter()
//        formater.numberStyle = .decimal
//        
//        video.value.numberOfViews.do {
//            let string = formater.string(from: NSNumber(integerLiteral: $0))
//            let nill = " "
//            cell.subTitleTixtView.text = video.value.channel.name + nill + string!
//        }
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = Constants.constatnWidth
//        let height = self.height * 9 / 16 + width
//        
//        return CGSize(width: view.frame.width, height: height + 16 + 68)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.menuBar.horizontalView.frame.origin.x = scrollView.contentOffset.x / 4
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
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.isPagingEnabled = true
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    private func setupNavigationItem() {
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        
        self.navigationItem.title = "Home"
        self.navigationItem.titleView = titleLable
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
    }
     
    private func scrollMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(row: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handlerMore() {
        self.settingsMenu.setupSettingMenu()
    }
    
    @objc func handlerSerch() {
        self.menuBar.observer.observer { menuBarStatus, _ in 
            switch menuBarStatus {
            case .home:
               self.scrollMenuIndex(menuIndex: 0)
            case .person:
                self.scrollMenuIndex(menuIndex: 1)
            case .fire:
                self.scrollMenuIndex(menuIndex: 2)
            case .youtube:
                self.scrollMenuIndex(menuIndex: 3)
            
            }
            
        }
//        self.scrollMenuIndex(menuIndex: 3)
    }
}
