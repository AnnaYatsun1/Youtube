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
 
    private let collectionView: UICollectionView
    private let model = ArrayModel(values: [Video]())
    private let videoManager = VideoNetworkService()

    //MARK: -
    //MARK: Initializations
    
    override init(frame: CGRect) {        
        let layout = UICollectionViewFlowLayout()
//        self.layout = layout

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
    
    // MARK:
    // MARK: Private
    
    private func fetchVideo () {
        self.videoManager.getVideo(self.model) { _ in 
     
        }
    }
    
    private func update() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        } 
    }
}
