//
//  PopupViewController.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/16.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet var btnStar: UIButton!
    @IBOutlet var lbTitle: UILabel!
    
    var index:Int?
    var db = DBHelper.shared
    var favoriteList:Array<Int>=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteList = db.fun_selectAll()
        // Do any additional setup after loading the view.
        fun_setbtnStar(state: favoriteList.contains(index!))
        lbTitle.text = dataList[index!][1]
        print(index!)
    }
    @IBAction func btnExit(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btnStarClick(_ sender: UIButton) {
        favoriteList = db.fun_selectAll()
        if favoriteList.contains(index!) { //true -> 즐찾해제 시킴
            db.deleteData(idx: String(index!))
            var i = favoriteList.firstIndex(of: index!)
            favoriteList.remove(at: i!)
            for i in favoriteList{
                db.insertData(idx: i)
            }
        }
        else{
            //false인 경우 -> 즐찾 추가 시킴
            db.insertData(idx: index!)
        }
        favoriteList = db.fun_selectAll()
        print(favoriteList)
        fun_setbtnStar(state: favoriteList.contains(index!))
    }
    func fun_setbtnStar(state:Bool){
        if state == false{
            btnStar.setImage(UIImage(named: "star.png"), for:.normal)
        }
        else{
            //state = ture
            btnStar.setImage(UIImage(named: "full_star.png"), for:.normal)
        }
    }

}
