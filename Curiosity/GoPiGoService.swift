//
//  GoPiGoService.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit

class GoPiGoService: NSObject {
    
    var taskId = 0
    
    
    func move(count: Int) {
        print(count)
    }
    
    func stop() {
        taskId = (taskId + 1)%1024
    }
    
    func recursiveMove(count: Int) {
        stop()
        DispatchQueue.global(qos: .userInteractive).async {
            let currentTask = self.taskId
            while (currentTask == self.taskId) {
                self.move(count: count)
                usleep(200)
            }
        }
    }
}
