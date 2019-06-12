//
//  VideoNetworkService.swift
//  Youtube
//
//  Created by Anna Yatsun on 20/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    
    static let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    static let subscriptions = "subscriptions.json"
    static let trending = "trending.json"
    static let home = "home.json"
}

class VideoNetworkService: RequestServiceTypeForAlamofire {
    private let model = ArrayModel(values: [Video]())
    private let parser = ParserJSONYoutubeAPI()
    
     
    public func getVideo(_ video: ArrayModel<Video>, completion: @escaping Closure.Execute<[Video]?>) -> NetworkTask? {
       return self.getVideo(url: "\(Constant.baseUrl)/\(Constant.home)", video, completion: completion)
    }
    
    public func getTrendingVideo(_ video: ArrayModel<Video>, completion: @escaping Closure.Execute<[Video]?>) -> NetworkTask? {
        return self.getVideo(url: "\(Constant.baseUrl)/\(Constant.trending)", video, completion: completion)
    }
    
    public func getsubscriptionsVideo(_ video: ArrayModel<Video>, completion: @escaping Closure.Execute<[Video]?>) -> NetworkTask? {
        return self.getVideo(url: "\(Constant.baseUrl)/\(Constant.subscriptions)", video, completion: completion)
    }
    
    private func getVideo(url: String, _ video: ArrayModel<Video>, completion: @escaping Closure.Execute<[Video]?>) -> NetworkTask? {
        let urlCountry = URL(string: url)
        
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
