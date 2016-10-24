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
    var taskId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesMoved(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        service.stop()
        didTouch(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        service.stop()
    }
    
    
    func didTouch(touches: Set<UITouch>) {
        //   service.recursiveMove()
    }

    
}
