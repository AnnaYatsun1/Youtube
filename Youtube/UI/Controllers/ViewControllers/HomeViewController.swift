//
//  HomeViewController1.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import  UIKit

class HomeViewController: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel, VerticalVideoCell> {
    
    override func viewDidLoad() {          
        super.viewDidLoad()
    }

//    private func scrollMenuIndex(menuIndex: Int) {
//        let indexPath = IndexPath(row: menuIndex, section: 0)
//        collectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
//        self.setTitleForIndex(index: menuIndex)
//    }
    
//    private func setTitleForIndex(index: Int) {
//        if  let titleLable: UILabel = cast(self.navigationItem.titleView) {
//            titleLable.text = self.presentationModel.titles[index]
//        }
//    }
}

class PersonViewController: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel, VerticalTrendingVideoCell> {
    
}

class SubscriptionViewController: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel, VerticalSubscriptionVideoCell> {
    
}

