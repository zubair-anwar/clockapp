//
//  StopwatchViewController.swift
//  ClockClone
//
//  Created by M Zubair on 16/05/2021.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet var tableView: UITableView!
    var laps: [String] = []
    var timer = Timer()
    var minutes : Int = 0
    var seconds:Int = 0
    var fractions:Int = 0
    var stopwatchString: String = ""
    var timerCounting:Bool = true
    var addLap:Bool = false
    @IBAction func startBtnClick(_ sender: UIButton) {
        if(timerCounting==true) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            timerCounting = false
            addLap = true
            btnStart.setTitle("Stop", for: .normal)
            btnReset.setTitle("Lap", for: .normal)
        } else {
            timer.invalidate()
            btnStart.setTitle("Start", for: .normal)
            btnReset.setTitle("Reset", for: .normal)
            timerCounting = true
            addLap = false
        }
    }
    @objc func updateStopwatch() {
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        stopwatchString = "\(minutesString):\(secondsString).\(fractionsString)"
        timerLabel.text = stopwatchString
    }
    @IBAction func resetBtnClick(_ sender: UIButton) {
        if addLap == true {
            laps.insert(stopwatchString, at: 0)
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Reset Timer?" , message: "Are you sure you would like to reset the timer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in

            }))
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
                self.addLap = false
                self.btnReset.setTitle("Lap", for: .normal)
                self.laps.removeAll(keepingCapacity: false)
                self.tableView.reloadData()
                self.fractions = 0
                self.seconds = 0
                self.minutes = 0
                self.stopwatchString = "00:00.00"
                self.timerLabel.text = self.stopwatchString
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerLabel.text = "00:00.00"
        btnStart.layer.cornerRadius = btnStart.frame.size.width/2
        btnReset.layer.cornerRadius = btnReset.frame.size.width/2
        let nib = UINib(nibName: "TimeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TimeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell",
                                                 for: indexPath) as? TimeTableViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.green
        cell!.selectedBackgroundView = backgroundView
        cell!.lapLabel.text = "Lap \(laps.count-indexPath.row)"
        cell!.timeLabel.text = laps[indexPath.row]
        return cell!
    }
}
