//
//  TimerViewController.swift
//  ClockClone
//
//  Created by M Zubair on 16/05/2021.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var btnStartTimer: UIButton!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var seconds = 60
    var timeToSet = 0
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
        btnStartTimer.layer.cornerRadius = btnStartTimer.frame.size.width/2
    }
    @IBAction func datePicker(_ sender: Any) {
    }
    
    @IBAction func btnStartTimer(_ sender: UIButton) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.timerClass), userInfo: nil, repeats: true)
    }
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    @objc func timerClass(){
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        let timeRemaining = String(format: "%02d:%02d", hour, minute)
//        seconds -= 1
//        txtTime.text = String(seconds)
//        if seconds == 0 {
//            timer.invalidate()
//        }
    }
}
