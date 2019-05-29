//
//  Channel.swift
//  Youtube
//
//  Created by Anna Yatsun on 06/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class Channel: NSObject {
    
    // MARK:
    // MARK:  Accessors
    
    var name: String
    var profileImageName: String
    
    //MARK: -
    //MARK: Initializations
    
    init(name: String, profileImageName: String) {
        self.name = name
        self.profileImageName = profileImageName
    }
}
