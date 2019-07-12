//
//  HomeControllerModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 02/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class HomeControllerModel: BasicControllerModel {
    
    override func configure() {
        self.fetchVideo(videoManager)
    }
    
    override func fetchVideo(_ networkService: VideoNetworkService) {
        networkService.getVideo(self.model)
    }
}
