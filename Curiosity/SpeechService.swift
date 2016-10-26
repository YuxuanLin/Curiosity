//
//  SpeechService.swift
//  Curiosity
//
//  Created by HaoBoji on 26/10/16.
//  Copyright © 2016 HaoBoji. All rights reserved.
//

import UIKit
import Speech

class SpeechService: NSObject, SFSpeechRecognizerDelegate {

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-UK"))
    private var enabled = false
    
    override convenience init() {
        self.init()
        speechRecognizer!.delegate = self
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            switch authStatus {  //5
            case .authorized:
                self.enabled = true
                break
            case .denied:
                print("User denied access to speech recognition")
                break
            case .restricted:
                print("Speech recognition restricted on this device")
                break
            case .notDetermined:
                print("Speech recognition not yet authorized")
                break
            }
            OperationQueue.main.addOperation() {
            }
        }
    }
    
}
