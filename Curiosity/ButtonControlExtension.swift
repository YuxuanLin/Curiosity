//
//  ButtonControlExtension.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit

extension MainController {
    
    func buttonPressed() {
        service.stop()
        if (leftUp.state == .highlighted && rightUp.state == .highlighted) {
            service.recursiveMove(count: 5)
        }
    }
}
