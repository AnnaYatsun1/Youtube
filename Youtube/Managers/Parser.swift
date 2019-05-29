//
//  Parser.swift
//  Youtube
//
//  Created by Anna Yatsun on 07/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

enum ParserErrors: Error {
    
    case dataError 
}

class Parser<Object: Decodable> {

    func object(from data: Data?) -> Result<Object, ParserErrors> {
        return data
            .flatMap { try? JSONDecoder().decode(Object.self, from: $0) }
            .map { Result.success($0) } 
            ?? .error(.dataError)
    }
}
