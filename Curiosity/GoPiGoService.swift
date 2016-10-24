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
    let url = "http://118.138.18.241:8000/controlcar"
    
    var taskId = 0
    
    
    func move(n1: Int, n2: Int, n3: Int, act: String) {
        let parameters = ["n1": n1, "n2": n2, "n3":n3, "act": act] as [String : Any]
        _ = Alamofire.request(url, parameters: parameters)
    }
    
    func stop() {
        taskId = (taskId + 1)%1024
    }
    
    func recursiveMove(count: Int) {
        stop()
        DispatchQueue.global(qos: .userInteractive).async {
            let currentTask = self.taskId
            while (currentTask == self.taskId) {
                self.move(n1: 1,n2: 1,n3: count,act: "w")
                usleep(200)
            }
        }
    }
}
