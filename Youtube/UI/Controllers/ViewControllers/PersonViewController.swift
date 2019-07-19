//
//  PersonViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class PersonViewController: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel, VerticalTrendingVideoCell> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(VerticalTrendingVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.trendingCellId.rawValue)
    }
}
