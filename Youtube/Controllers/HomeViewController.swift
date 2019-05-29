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
   
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLable.textColor = UIColor.white
        titleLable.text = "Home"
        titleLable.font = UIFont.systemFont(ofSize: 20)
        
        self.navigationItem.title = "Home"
        self.navigationItem.titleView = titleLable
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
       
        let collectionView = self.collectionView
        collectionView?.backgroundColor = UIColor.white        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        self.setupMenuBer()
        self.setupNavBarButtons()
        self.fetchVideo()
        self.redirectToNewController()
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
        return self.model.count        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt cellForItemAtindexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: cellForItemAtindexPath) as! VideoCell
        
        let video = self.model[cellForItemAtindexPath.row]
        cell.titleLable.text = video.value.title
        let urlString = video.value.tubnnailImageName 
        let url = URL(string: urlString)
        let placeholder = Image(named: "placeholder")
        cell.thumbnailImageView.kf.setImage(with: url, placeholder: placeholder)
        
        let userProfileImage = video.value.channel.profileImageName
        let urlImageProfile = URL(string: userProfileImage)
        cell.userProfileImageView.kf.setImage(with: urlImageProfile)
        
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        
        video.value.numberOfViews.do {
            let string = formater.string(from: NSNumber(integerLiteral: $0))
            let nill = " "
            cell.subTitleTixtView.text = video.value.channel.name + nill + string!
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16 + 50
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
    
    @objc func handlerMore() {
        self.settingsMenu.setupSettingMenu()
    }
    
    @objc func handlerSerch() {
        print(123)
    }
}
