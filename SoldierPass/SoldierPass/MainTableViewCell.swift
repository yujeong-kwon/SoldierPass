//
//  MainTableViewCell.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/06.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var lbTitleText: UILabel!
    @IBOutlet var lbSubTitleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
