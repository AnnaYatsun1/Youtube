//
//  Video.swift
//  Youtube
//
//  Created by Anna Yatsun on 06/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class Video: NSObject {
    // MARK:
    // MARK:  Accessors
    
    var tubnnailImageName: String
    var title: String?
    var channel: Channel
    var numberOfViews: Int?
    var updateDate: Int?
    
    //MARK: -
    //MARK: Initializations
    
    init(title: String, numberOfViews: Int, tubnnailImageName: String, channel: ChannelJSON, updateDate: Int) {
        self.title = title
        self.numberOfViews = numberOfViews
        self.tubnnailImageName = tubnnailImageName
        self.channel = Channel(name: channel.name, profileImageName: channel.profileImageName)
        self.numberOfViews = numberOfViews
        self.updateDate = updateDate
    }

}
