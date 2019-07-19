//
//  HomeDataSource.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit




class HomeDataSource: NSObject {
    
    var viewModel: HomePresentationModel?
    
    // MARK: - Initialization
    
    init(viewModel: HomePresentationModel) {
        self.viewModel = viewModel
        
        super.init()
    }
}

extension HomeDataSource: UICollectionViewDataSource {
    
    public func count() -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let indentifire = self.cellIndentifire(indexPathItem: indexPath.item)
        
        return cast(collectionView.dequeueReusableCell(withReuseIdentifier: indentifire.rawValue, for: indexPath)) ?? VerticalVideoCell()
    }
    
    private func cellIndentifire(indexPathItem: Int) -> ConstantsStringCellID {
        switch indexPathItem {
        case 1:
            return .trendingCellId
        case 2:
            return .subscriptionCellId
        default:
            return .cellId
        }
    }
}
