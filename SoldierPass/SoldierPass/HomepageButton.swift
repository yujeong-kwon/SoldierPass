//
//  HomepageButton.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/16.
//

import UIKit

class HomepageButton: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0
        self.backgroundColor = .primary
        self.tintColor = UIColor.white
    }
}
