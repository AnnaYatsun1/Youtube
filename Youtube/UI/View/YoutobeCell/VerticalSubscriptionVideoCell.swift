//
//  VerticalSubscriptionVideoCell.swift
//  Youtube
//
//  Created by Anna Yatsun on 12/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class VerticalSubscriptionVideoCell: VerticalVideoCell {
   
    override func fetchVideo() {
        self.videoManager.getsubscriptionsVideo(self.model) { _ in 
      
        }
    }
}
