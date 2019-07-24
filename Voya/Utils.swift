//
//  Utils.swift
//  Voya
//
//  Created by yaakov on 4/10/19.
//  Copyright © 2019 yaakov. All rights reserved.
//

import Foundation
import AudioToolbox

class Sounds {

    func playSessionStartSound(completion: @escaping (() -> Void)) {
        let soundFileName = "long_beep"

        if let customSoundUrl = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            AudioServicesPlayAlertSoundWithCompletion(customSoundId) {
                completion()
            }
        } else {
            completion()
        }
    }

    func playAlertSound(completion: @escaping (() -> Void)) {
        let soundFileName = "simple_beep"

        if let customSoundUrl = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") {
            var customSoundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(customSoundUrl as CFURL, &customSoundId)
            AudioServicesPlayAlertSoundWithCompletion(customSoundId) {
                completion()
            }
        } else {
            completion()
        }
    }
}
