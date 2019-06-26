//
//  MenuBarViewModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 26/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

struct MenuBarViewModel {
    
    enum BarState: Int {
        case home = 0
        case person
        case youtube
        case fire
    }
    
    let handler: ((BarState) -> ())?
    let iconNames = ["home", "person", "youtube", "fire"]
}
