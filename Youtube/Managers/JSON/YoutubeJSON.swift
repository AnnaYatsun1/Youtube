//
//  YotubeJSON.swift
//  Youtube
//
//  Created by Anna Yatsun on 20/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public struct YoutubeJSON: Decodable {
    let title: String
    let numberOfViews: Int
    let thumbnailImageName: String
    let channel: ChannelJSON
    let duration: Int
   
    enum CodingKeys: String, CodingKey {
        case title
        case numberOfViews = "number_of_views"
        case thumbnailImageName = "thumbnail_image_name"
        case channel
        case duration
    }
}

public struct ChannelJSON: Decodable {
    let name: String
    let profileImageName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}
