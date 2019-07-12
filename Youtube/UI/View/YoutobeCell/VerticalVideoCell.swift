//
//  Cell.swift
//  Youtube
//
//  Created by Anna Yatsun on 31/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

fileprivate struct Constants {
    static let constatn:CGFloat = 32
    static let constatnWidth: CGFloat = 50
}

class VerticalVideoCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK:
    // MARK:  Accessors
    
    public let observeringModel = CancellableObject()
    public let model = ArrayModel(values: [Video]())
    public let videoManager = VideoNetworkService()
 
    private let collectionView: UICollectionView
    private let vodeoPlayer = VideoPlayer()
   
    //MARK: -
    //MARK: Initializations
    
    override init(frame: CGRect) {        
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)  
        
        super.init(frame: frame)
        self.collectionView.backgroundColor = .white
        self.fetchVideo()
        self.addSubview(self.collectionView)
        
        
        self.observeringModel.value = self.model.observer { state, _ in 
            switch state {
            case .add: self.update()
            case .remove: break
            case .update: self.update()
            }
        }
        
        self.collectionView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().offset(50)
            maker.left.right.equalToSuperview()
        }
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count        
    }
        
   func collectionView(_ collectionView: UICollectionView, cellForItemAt cellForItemAtindexPath: IndexPath) -> UICollectionViewCell {
            let cell = cast(collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: cellForItemAtindexPath)) ?? VideoCell()
            let video = self.model[cellForItemAtindexPath.row]
            cell.fill(video: video.value)  
    
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                 return CGSize(width: self.frame.width, height: 250)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vodeoPlayer.setupVideoPlayer()
    }
    
    // MARK:
    // MARK: Public
    
    func fetchVideo () {
        self.videoManager.getVideo(self.model) { _ in 
            
        }
    }
    
    // MARK:
    // MARK: Private
        
    private func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        } 
    }
}

//class VerticalVideo: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    public let observeringModel = CancellableObject()
//    public let model = ArrayModel(values: [Video]())
//    public let videoManager = VideoNetworkService()
//    
//    private let vodeoPlayer = VideoPlayer()
//    private var dataSource: VideoDataSource?
//    
//    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: layout)
//      
//    }    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.collectionView?.dataSource = dataSource
//        self.fetchVideo()
//    }
//    
//    func fetchVideo () {
//        self.videoManager.getVideo(self.model) { _ in 
//        
//        }
//    }
//}
//
//
//class VideoDataSource: NSObject, UICollectionViewDataSource {
//    
//    public let model = ArrayModel(values: [Video]())
//    public func count() -> Int {
//        return self.model.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.count()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let indentifire = self.cellIndentifire(indexPathItem: indexPath.item)
//        
//        return cast(collectionView.dequeueReusableCell(withReuseIdentifier: indentifire.rawValue, for: indexPath)) ?? VerticalVideoCell()
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
//}
