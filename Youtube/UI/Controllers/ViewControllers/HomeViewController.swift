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
        self.view.backgroundColor = .white
        
        
        super.viewDidLoad()
        
        self.collectionView.register(VerticalVideoCell.self, forCellWithReuseIdentifier: ConstantsStringCellID.cellId.rawValue)
    }
}





