//
//  CameraViewController.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet var leftUp: UIButton!
    @IBOutlet var leftDown: UIButton!
    @IBOutlet var rightUp: UIButton!
    @IBOutlet var rightDown: UIButton!

    // Buttons pressed
    @IBAction func leftUpAction(_ sender: AnyObject) {
        buttonPressed()
    }
    @IBAction func leftDownAction(_ sender: AnyObject) {
        buttonPressed()
    }
    @IBAction func rightUpAction(_ sender: AnyObject) {
        buttonPressed()
    }
    @IBAction func rightDownAction(_ sender: AnyObject) {
        buttonPressed()
    }
    
    let service = GoPiGoService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
