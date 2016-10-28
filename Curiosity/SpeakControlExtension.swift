//
//  SpeakControlExtension.swift
//  Curiosity
//
//  Created by HaoBoji on 25/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit

extension MainController {

    func speakButtonPressed() {
        // service.moveWithSteps(action: "rotate left", steps: 1)
        
        if speech.audioEngine.isRunning {
            speech.audioEngine.stop()
            speech.recognitionRequest?.endAudio()
        } else {
            speech.startRecording() { result in
                print(result)
                if (result == nil) {
                    return
                }
                let text = result!.lowercased()
                if (text.contains("forward")) {
                    let steps = self.parseSteps(text: text, control: "forward")
                    self.service.moveWithSteps(action: "move forward", steps: steps)
                } else if (text.contains("backward")) {
                    let steps = self.parseSteps(text: text, control: "backward")
                    self.service.moveWithSteps(action: "move backward", steps: steps)
                }
            }
            
        }
    }
    
    func parseSteps(text: String, control: String) -> Int {
        var steps = 10
        if (text.contains("steps")) {
            let count = self.parseCount(result: text, after: "control", before: "steps")
            if (count != nil) {
                steps = count!
            }
        }
        return steps
    }
    
    func parseCount(result: String, after: String, before: String) -> Int? {
        let count = result.replacingOccurrences(of: after + " ", with: "").replacingOccurrences(of: " " + before, with: "")
        return Int(count)
    }
}
