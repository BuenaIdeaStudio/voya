//
//  ViewController.swift
//  Voya
//
//  Created by yaakov on 3/31/19.
//  Copyright © 2019 yaakov. All rights reserved.
//

import UIKit
import MZTimerLabel

struct Counter {
    var seconds: Int
    var milliseconds: Int
}

class ViewController: UIViewController {

    let blManager: BluetoothManager = BluetoothManager()
    
    @IBOutlet weak var mainTimerLabel: UILabel!
    @IBOutlet weak var triggerButton: UIButton!
    @IBOutlet weak var timeControlSlider: UISlider!

    @IBOutlet weak var fstopLogLabel: UILabel!
    var counter: TimeInterval = 0
    var timer: MZTimerLabel?
    var fstops: FStops?
    var isLampEnabled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTimer()
        timeControlSlider.minimumValue = 0.0
//        timeControlSlider.maximumValue = 60.0 * 60.0
        timeControlSlider.maximumValue = 99.0
        timeControlSlider.addTarget(self, action: #selector(sliderTimeUpdated(slider:)), for: .valueChanged)
    }

    func setupTimer() {
        timer = MZTimerLabel.init(
            label: mainTimerLabel,
            andTimerType: MZTimerLabelTypeTimer
        )
        timer?.timeFormat = "ss:SS"
        timer?.setCountDownTime(counter)
    }

    @objc func sliderTimeUpdated(slider: UISlider) {
        print(slider.value.debugDescription)
        counter = TimeInterval.init(slider.value/100)
        timer?.setCountDownTime(counter)
    }

    func resetSlider() {
        timeControlSlider.setValue(0.0, animated: true)
    }
}

extension ViewController {

    @IBAction func addTime(_ sender: UIButton) {
        if timer?.counting == true { return }
        counter = counter + 1
        timer?.setCountDownTime(counter)
    }

    @IBAction func removeTime(_ sender: UIButton) {
        if timer?.counting == true { return }

        if counter == 1 {
            counter = 0
            timer?.setCountDownTime(counter)
            return
        }

        counter = counter - 1
        timer?.setCountDownTime(counter)
    }

    @IBAction func startTimer(_ sender: UIButton) {
        if timer?.counting == true {
            stop()
            return
        }

        if counter == 0 { return }

        Sounds().playSessionStartSound { [weak self] in
            self?.startSession()
        }
//        timer?.setCountDownTime(counter)
//        timer?.reset()
//
//
//        blManager.sendOnCommand()
//
//        timer?.start(ending: { [weak self] (interval) in
//            guard let c = self?.counter else { return }
//
//            self?.blManager.sendOffCommand()
//            self?.timer?.setStopWatchTime(c)
//        })
    }

    @IBAction func resetTimer(_ sender: UIButton) {
        resetSlider()
        reset()
    }

    @IBAction func turnOnElargerTouched(_ sender: UIButton) {
        if isLampEnabled == true {
            self.lampSwithToggle()
            return
        } else {
            Sounds().playAlertSound {[weak self] in
                self?.lampSwithToggle()
            }
        }
    }

    func reset() {
        counter = 0
        timer?.setCountDownTime(counter)
        timer?.reset()
        blManager.sendOffCommand()
    }

    func stop() {
        timer?.pause()
        blManager.sendOffCommand()
    }

    func startBottonMode() {
        triggerButton.setTitle("Start", for: .normal)
    }

    func stopButtonMode() {
        triggerButton.setTitle("Stop", for: .normal)
    }

    func startSession() {
//        DispatchQueue.main.async {
//
//        }

        DispatchQueue.main.sync { [weak self] in
            self?.timer?.setCountDownTime(self?.counter ?? 0.0)
            self?.timer?.reset()

            self?.blManager.sendOnCommand()

            self?.timer?.start(ending: { [weak self] (interval) in
                guard let c = self?.counter else { return }

                self?.blManager.sendOffCommand()
                self?.timer?.setStopWatchTime(c)
            })
        }
//        timer?.setCountDownTime(counter)
//        timer?.reset()
//
//        blManager.sendOnCommand()
//
//        timer?.start(ending: { [weak self] (interval) in
//            guard let c = self?.counter else { return }
//
//            self?.blManager.sendOffCommand()
//            self?.timer?.setStopWatchTime(c)
//        })
    }
}

extension ViewController {

    func lampSwithToggle() {
        if isLampEnabled == true {
            blManager.sendOffCommand()
            isLampEnabled = false
        } else {
            blManager.sendOnCommand()
            isLampEnabled = true
        }
    }
}
