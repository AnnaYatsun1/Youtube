//
//  ControllerModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation


protocol ControllerModel { // хранение стейтов, обработка стейтов, походы на сервер
    
    func configure()
}

class HomeControllerModel: ControllerModel {
    public let videoManager = VideoNetworkService()
    public let model = ArrayModel(values: [Video]())
    
    
    func configure() {
        self.fetchVideo()
    }
    
    private func fetchVideo () {
        self.videoManager.getVideo(self.model)
    }
}

