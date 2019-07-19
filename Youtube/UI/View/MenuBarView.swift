//
//  MenuBarView.swift
//  Youtube
//
//  Created by Anna Yatsun on 19/04/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import SnapKit

class FirstUIViewController: UIView {
    
    
}

class MenuBarController: UITabBarController {
//    
    override func viewDidLoad() {

        let firstViewController = SettingsViewController()
        
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController = HelpViewController()
        
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]
        
        viewControllers = tabBarList
    }
    
}


class MenuBarView: UIView { 
    
    typealias State = MenuBarViewModel.BarState
    
    // MARK:
    // MARK: Properties
    
    public let horizontalView = UIView()
    
    public var viewModel: MenuBarViewModel?
    public var cellsCount: Int {  return self.viewModel?.iconNames.count ?? 0 }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
        
    private let cellId = "cellId"    
   
    private lazy var horizontalBarWidth = self.frame.width / CGFloat(self.cellsCount) 
    
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

// MARK:
// MARK: UICollectionViewDelegate & UICollectionViewDataSource

extension MenuBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cast(collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)) ?? MenuCell()
        
        if let iconName = self.viewModel?.iconNames[indexPath.row] {
            cell.fill(image: UIImage(named: iconName))
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView, 
        layout collectionViewLayout: UICollectionViewLayout, 
        sizeForItemAt indexPath: IndexPath
        ) 
        -> CGSize 
    {
        let count = CGFloat(self.cellsCount)
        
        return CGSize(width: self.frame.width / count, height: self.frame.height)
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
        UIView.animate(withDuration: 0.75) {            
            if let currentState = State(rawValue: indexPath.row) {
                self.viewModel?.handler?(currentState)
            }
            
            self.horizontalView.frame.origin.x = CGFloat(indexPath.item) * self.horizontalBarWidth
        } 
    }
}
