//
//  GoPiGoService.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit
import Alamofire


class GoPiGoService: NSObject {
    
    // n1=1&n2=1&n3=1&act=w
    let url = "http://118.138.27.75:8000/"
    var request: DataRequest?
    
    func stop() {
        request = Alamofire.request(url + "stop").response(completionHandler: { (_) in
            self.request = nil
        })
    }
    
    func moveContinuous(action: String, leftSpeed: Int, rightSpeed: Int) {
        if (request == nil) {
            let prameters = ["action": action, "leftSpeed": leftSpeed, "rightSpeed": rightSpeed] as [String : Any]
            request = Alamofire.request(url + "moveContinuous", parameters: prameters).response(completionHandler: { (_) in
                self.request = nil
            })
        }
    }
    
    
    
//    func stop() {
//        taskId = (taskId + 1)%1024
//    }
    
//    
//    func recursiveMove(count: Int) {
//        stop()
//        DispatchQueue.global(qos: .userInteractive).async {
//            let currentTask = self.taskId
//            while (currentTask == self.taskId) {
//                self.move(action: "w")
//                usleep(100000)
//                print(1)
//            }
//        }
//    }
}
