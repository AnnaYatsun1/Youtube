//
//  ParserJSONYoutubeAPI.swift
//  Youtube
//
//  Created by Anna Yatsun on 07/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class MyError: Error {
    
}

class ParserJSONYoutubeAPI: Parser<[YoutubeJSON]> {
    
    public func convert(data: Data) -> Result<[Video], ParserErrors> {
      return  self.object(from: data).map { youtubeJson in 
            youtubeJson.map { youtube in
                Video(title: youtube.title, 
                      numberOfViews: youtube.numberOfViews,
                      tubnnailImageName: youtube.thumbnailImageName, 
                      channel: youtube.channel, 
                      updateDate: youtube.duration
                )
            }
        }
    }
}

