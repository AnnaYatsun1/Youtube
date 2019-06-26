//
//  BaseScrollMenu.swift
//  Youtube
//
//  Created by Anna Yatsun on 29/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit


enum EventNavBarState {
    case home
    case person
    case youtube
    case fire
}

class MenuControllerObserver: UIView {

    // MARK:
    // MARK:  Accessors
    public var observer = ObservableObject<EventNavBarState>()

    // MARK:
    // MARK:  Public
    func moveToHome() {
        self.observer.notify(new: .home)
    }
    
    func moveToPerson() {
        self.observer.notify(new: .person)
    }
    
    func moveToYoutube() {
        self.observer.notify(new: .youtube)
    }
    
    func moveToFire() {
        self.observer.notify(new: .fire)
    }
}
//
//
//class Observer: UIView {
//    
//    // MARK:
//    // MARK:  Accessors
//    public var observer = ObservableObject<EventNavBarState>()
//    
//    // MARK:
//    // MARK:  Public
//    func moveToHome() {
//        self.observer.notify(new: .home)
//    }
//    
//    func moveToPerson() {
//        self.observer.notify(new: .person)
//    }
//    
//    func moveToYoutube() {
//        self.observer.notify(new: .youtube)
//    }
//    
//    func moveToFire() {
//        self.observer.notify(new: .fire)
//    }
//}

class MenuObserver {
//    public var observer = ObservableObject<EventNavBarState>()
    
    // MARK:
    // MARK:  Public
//    func moveToHome() {
//        self.observer.notify(new: .home)
//    }
//    
//    func moveToPerson() {
//        self.observer.notify(new: .person)
//    }
//    
//    func moveToYoutube() {
//        self.observer.notify(new: .youtube)
//    }
//    
//    func moveToFire() {
//        self.observer.notify(new: .fire)
//    }
}
