//
//  MovieTableViewCell.swift
//  SoldierPass
//
//  Created by 권유정 on 2022/08/19.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var rank: UILabel!
    
    @IBOutlet var movieName: UILabel!
    @IBOutlet var rankInten: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
