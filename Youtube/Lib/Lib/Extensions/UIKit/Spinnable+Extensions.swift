//
//  Spinnable+Extensions.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

import UIKit

import MBProgressHUD


extension Spinnable where Self: UIViewController {
    
    func showSpinner() {
        self.viewIfLoaded.do(self.showSpinner)
    }
    
    func hideSpinner() {
        self.viewIfLoaded.do(self.hideSpinner)
    }
    
    func showSpinner(on object: UIView) {
        self.viewIfLoaded.do {
            MBProgressHUD.showAdded(to: $0, animated: true)
        }
    }
    
    func hideSpinner(from object: UIView) {
        self.viewIfLoaded.do {
            MBProgressHUD.hide(for: $0, animated: true)
        }
    }
}

extension Spinnable where Self: UIView {
    
    func showSpinner() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func hideSpinner() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
