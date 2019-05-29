//
//  BaseViewControllerObserver.swift
//  Youtube
//
//  Created by Anna Yatsun on 27/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit


class BaseViewControllerObserver: UIView {
    
    public let observer = ObservableObject<EventMenuState>()
 
    func moveToSettings() {
        self.observer.notify(new: .settings)
    }
    
    func moveToHelp() {
        self.observer.notify(new: .help)
    }
    
    func moveToCancel() {
        self.observer.notify(new: .cancel)
    }
}
