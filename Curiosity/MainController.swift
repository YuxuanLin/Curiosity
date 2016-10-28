//
//  CameraViewController.swift
//  Curiosity
//
//  Created by HaoBoji on 24/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit
import CoreMotion

class MainController: UIViewController {
    
    @IBOutlet var leftUp: UIButton!
    @IBOutlet var leftDown: UIButton!
    @IBOutlet var rightUp: UIButton!
    @IBOutlet var rightDown: UIButton!
    
    @IBOutlet var speak: UIButton!
    
    @IBAction func speaking(_ sender: AnyObject) {
        speakButtonPressed()
    }
    
    @IBAction func stopCar(_ sender: UIButton) {
        service.stop()
    }
    
    // network service
    let service = GoPiGoService()
    let speech = SpeechService()
    
    // gravity
    let motionManager = CMMotionManager()    
    // Buttons pressed
    @IBAction func controlButtonChanged(_ sender: UIButton) {
        // buttonPressed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        monitorControlButtons()
        motionManager.startDeviceMotionUpdates()
    }
    
}
