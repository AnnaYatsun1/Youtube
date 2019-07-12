//
//  TrendingVideoModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 02/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


class TrendingModel: BasicControllerModel {
    override func configure() {
        self.fetchVideo(videoManager)
    }
    
    override func fetchVideo(_ networkService: VideoNetworkService) {
        networkService.getTrendingVideo(self.model)  { _ in 
            
        }
    }
}
