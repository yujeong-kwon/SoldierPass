//
//  FavoriteTableViewCell.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/17.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet var lbFavoriteTitleText: UILabel!
    @IBOutlet var lbFavoriteSubTitleText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
