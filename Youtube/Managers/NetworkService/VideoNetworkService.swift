//
//  VideoNetworkService.swift
//  Youtube
//
//  Created by Anna Yatsun on 20/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    
    static let mainUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
}

class VideoNetworkService: RequestServiceTypeForAlamofire {
    private let model = ArrayModel(values: [Video]())
    private let parser = ParserJSONYoutubeAPI()
    
     public func getVideo(_ video: ArrayModel<Video>, completion: @escaping Closure.Execute<[Video]?>) -> NetworkTask? {
        let urlCountry = URL(string: Constant.mainUrl)
        
          return  urlCountry.map { url in
                requestData(url: url) { dataRequest in 
                    dataRequest.map { data in 
                        data.do { 
                            self.parser.convert(data: $0)
                                .analysis(
                                    success: {
                                        video.addAll(values: $0)
                                        completion($0)
                                },
                            failure: { _ in
                            
                            }
                        )
                    }
                }
            }
        }
    }
}
