//
//  ViewModel.swift
//  Youtube
//
//  Created by Anna Yatsun on 01/07/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ViewModel<Events> { // Хроняться вьюхи, и отвечает за хендлинг ивентов с вьюхи
    var eventHandler: ((Events) -> ())?
}
