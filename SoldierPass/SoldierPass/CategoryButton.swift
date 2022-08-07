//
//  CategoryButton.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/06.
//

import UIKit

class CategoryButton: UIButton {

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 8.0
        self.backgroundColor = UIColor.lightGray
        self.tintColor = UIColor.white
    }

}
