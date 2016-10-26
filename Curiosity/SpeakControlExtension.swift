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
        service.moveWithSteps(action: "rotate left", steps: 1)
    }
}
