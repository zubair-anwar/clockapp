//
//  TimeTableViewCell.swift
//  ClockClone
//
//  Created by M Zubair on 03/05/2021.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet var lapLabel : UILabel!
    @IBOutlet var timeLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
