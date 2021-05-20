//
//  AddScreenViewController.swift
//  ClockClone
//
//  Created by M Zubair on 17/05/2021.
//

import UIKit

class AddScreenViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.preferredDatePickerStyle = .wheels
    }

}
