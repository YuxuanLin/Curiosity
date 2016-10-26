//
//  ButtonControlExtension.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit
import CoreMotion

extension MainController {
    
    func monitorControlButtons() {
        DispatchQueue.global(qos: .userInteractive).async {
            // self.leftUp.state == .highlighted || self.rightUp.state == .highlighted || self.leftDown.state == .highlighted || self.rightDown.state == .highlighted
            while (true) {
                usleep(10000)
                var leftSpeed = 100
                var rightSpeed = 100
                if (self.motionManager.deviceMotion?.gravity.y != nil) {
                    let tilt = self.motionManager.deviceMotion!.gravity.y
                    leftSpeed = leftSpeed + Int(tilt * 50)
                    rightSpeed = rightSpeed - Int(tilt * 50)
                }
                
                if (self.leftUp.state == .highlighted && self.rightUp.state == .highlighted) {
                    self.service.moveContinuous(action: "move forward", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.leftDown.state == .highlighted && self.rightDown.state == .highlighted) {
                    self.service.moveContinuous(action: "move backward", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.leftUp.state == .highlighted && self.rightDown.state == .highlighted) {
                    self.service.moveContinuous(action: "rotate left", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.leftDown.state == .highlighted && self.rightUp.state == .highlighted) {
                    self.service.moveContinuous(action: "rotate right", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.leftUp.state == .highlighted) {
                    self.service.moveContinuous(action: "turn left", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.rightUp.state == .highlighted) {
                    self.service.moveContinuous(action: "turn right", leftSpeed: leftSpeed, rightSpeed: rightSpeed)
                } else if (self.leftDown.state == .highlighted) {
                    self.service.moveContinuous(action: "move backward", leftSpeed: 0, rightSpeed: rightSpeed)
                } else if (self.rightDown.state == .highlighted) {
                    self.service.moveContinuous(action: "move backward", leftSpeed: leftSpeed, rightSpeed: 0)
                }
            }
        }
    }
}
