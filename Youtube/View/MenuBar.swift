//
//  MenuBar.swift
//  Youtube
//
//  Created by Anna Yatsun on 19/04/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit

//fileprivate struct Constant {
//    static let home = "home"
//    static let person = "person"
//    static let youtube = "youtube"
//    static let fire = "fire"
//}

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout { 
    
    // MARK:
    // MARK:  Accessors
    
    lazy fileprivate var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    private let cellId = "cellId"
    private let imageNames = ["home", "person", "youtube", "fire"]
    private let horizontalView = UIView()
    
    private lazy var horizontalBarWidth = self.frame.width / 4 
    
    //MARK: -
    //MARK: Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
        self.collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        self.collectionView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.bottom.equalToSuperview()
        }
        self.setupHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! MenuCell
        cell.imagesView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView, 
        layout collectionViewLayout: UICollectionViewLayout, 
        sizeForItemAt indexPath: IndexPath
    ) 
        -> CGSize 
    {
        return CGSize(width: self.frame.width / 4, height: self.frame.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView, 
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    )
        -> CGFloat 
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.75){
            self.horizontalView.frame.origin.x = CGFloat(indexPath.item) * self.horizontalBarWidth
        } 
    }
    
    private func setupHorizontalBar() {
        self.horizontalView.backgroundColor = UIColor.white
        self.addSubview(self.horizontalView)
        
        self.horizontalView.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview().dividedBy(4)
            maker.height.equalTo(4)
        }
    }
}
