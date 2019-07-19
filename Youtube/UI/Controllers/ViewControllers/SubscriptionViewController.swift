//
//  SubscriptionViewController.swift
//  Youtube
//
//  Created by Anna Yatsun on 15/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class SubscriptionViewController: ViewController<HomePresentationModel, HomeEvents, HomeViewModel, HomeControllerModel, VerticalSubscriptionVideoCell> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(VerticalSubscriptionVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.subscriptionCellId.rawValue)
    }
    
}
