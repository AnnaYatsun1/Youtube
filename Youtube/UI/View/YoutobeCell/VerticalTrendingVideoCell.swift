//
//  VerticalTrendingVideoCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit


class VerticalTrendingVideoCell: VerticalVideoCell {
  
    override func fetchVideo() {
        self.videoManager.getTrendingVideo(self.model) { _ in 
            
        }
    }
}

