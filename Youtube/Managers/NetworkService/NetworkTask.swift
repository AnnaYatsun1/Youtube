//
//  NetworkTask.swift
//  Youtube
//
//  Created by Anna Yatsun on 20/05/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class NetworkTask: Cancellable {
    
    public private(set) var isCancelled = false
    
    private let task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    public func cancel() {
        if self.task.state == .running {
            self.task.cancel()
        }
        
        self.isCancelled = true
    }
}
