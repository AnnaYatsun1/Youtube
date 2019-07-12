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

class BasicControllerModel: ControllerModel {
    public let model = ArrayModel(values: [Video]())
    public let videoManager = VideoNetworkService()   
    
    func configure() {
        self.fetchVideo(videoManager)
    }
    
    func fetchVideo(_ networkService: VideoNetworkService) {
        
    }
}

