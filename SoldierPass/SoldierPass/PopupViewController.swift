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
    @IBOutlet var lbContents: UILabel!
    @IBOutlet var phoneIcon: UILabel!
    @IBOutlet var lbCallNumber: UILabel!
    @IBOutlet var addressIcon: UILabel!
    @IBOutlet var lbAddress: UILabel!
    
    
    var index:Int?
    var db = DBHelper.shared
    var favoriteList:Array<Int>=[]
    
    //인덱스, 시설명, 지역, 카테고리, 상세설명, 연락처, 홈페이지, 상세주소, 즐찾여부
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbContents.numberOfLines = 0
        
        favoriteList = db.fun_selectAll()
        // Do any additional setup after loading the view.
        fun_setbtnStar(state: favoriteList.contains(index!))
        lbTitle.text = dataList[index!][1]
        //상세 설명
        lbContents.text = dataList[index!][4]
        lbContents.sizeToFit()
        //전화번호
        let attachment_phone = NSTextAttachment()
        attachment_phone.image = UIImage(named: "icons8-전화-30.png")
        let attachmentString_phone = NSAttributedString(attachment: attachment_phone)
        phoneIcon.attributedText = attachmentString_phone
        lbCallNumber.text = dataList[index!][5]
        //주소
        let attachment_address = NSTextAttachment()
        attachment_address.image = UIImage(named: "icons8-채점자-30.png")
        let attachmentString_address = NSAttributedString(attachment: attachment_address)
        addressIcon.attributedText = attachmentString_address
        lbAddress.text = dataList[index!][7]
        
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
    @IBAction func btnConnectPage(_ sender: HomepageButton) {
        let homepageURL = URL(string: dataList[index!][6])
        UIApplication.shared.open(homepageURL!, options: [:])
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
