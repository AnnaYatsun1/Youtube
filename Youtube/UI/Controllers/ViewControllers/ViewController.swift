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

class ViewController<PresentationViewModel: PresentationModel, Events, ViewModelType: ViewModel<Events>, Model: ControllerModel, Cell: UICollectionViewCell>: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    // отвечает за навигацию, и вызова моделей
    
    let presentationModel: PresentationViewModel
    let viewModel: ViewModelType
    let model: Model
    let dataSource: UICollectionViewDataSource
    
    public lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe(_:)))
        swipe.direction = .right
        swipe.delegate = self
        
        return swipe
    }()
    
    public lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe(_:)))
        swipe.direction = .left
        swipe.delegate = self
        
        return swipe
    }()

    init(presentationModel: PresentationViewModel, viewModel: ViewModelType, model: Model, uiCollectionViewLayout: UICollectionViewLayout, dataSource: UICollectionViewDataSource) {
        self.presentationModel = presentationModel
        self.viewModel = viewModel
        self.model = model
        self.dataSource = dataSource
                        
        super.init(collectionViewLayout: uiCollectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.addGestureRecognizer(swipeRight)
        self.collectionView.addGestureRecognizer(swipeLeft)
        self.model.configure()
        self.presentationModel.prepareLayout()
        self.presentationModel.prepareStyle()
        self.presentationModel.prepareConstraints()
        self.setupCollectionView()
        self.setupNavigationItem()        
    }
    
    @objc func leftSwipe(_ sender: UISwipeGestureRecognizer?) {

    }
    
    @objc func rightSwipe(_ sender: UISwipeGestureRecognizer?) {
        
    }
    
    private func setupCollectionView() {
        let collectionView = self.collectionView
        if  let layout: UICollectionViewFlowLayout = cast(self.collectionView?.collectionViewLayout) {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
        }
        
        collectionView.do {
            $0.backgroundColor = UIColor.white
            $0.isPagingEnabled = true
            $0.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
            $0.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
            $0.dataSource = self.dataSource
            $0.register(Cell.self, forCellWithReuseIdentifier: ConstantsStringCellID.cellId.rawValue)
            $0.register(Cell.self, forCellWithReuseIdentifier: ConstantsStringCellID.trendingCellId.rawValue)
            $0.register(Cell.self, forCellWithReuseIdentifier: ConstantsStringCellID.subscriptionCellId.rawValue)
        }
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = self.presentationModel.titleLable?.text
        self.navigationItem.titleView =  self.presentationModel.titleLable
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = true
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

}


