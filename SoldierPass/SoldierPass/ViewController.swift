//
//  ViewController.swift
//  SoldierPass
//
//  Created by 권유정 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var showPicker: UITextField!
    
    @IBOutlet var btnHotel: CategoryButton!
    @IBOutlet var btnMovie: CategoryButton!
    @IBOutlet var btnAirplane: CategoryButton!
    @IBOutlet var btnRent: CategoryButton!
    @IBOutlet var btnMove: CategoryButton!
    @IBOutlet var btnTicket: CategoryButton!
    
    var dataController:BenefitsDataController = BenefitsDataController()
    var data:[[String]]=[]
    var cityList:[String]=["전국","서울","인천","대전","광주","대구","울산","부산","경기","강원","충북","충남","전북","전남","경북","경남","제주"]
    var selectCity = "전국"
    
    let notSelectedBtnBgColor = UIColor.lightGray
    let notSelectedBtnTextColor = UIColor.white
    //let selectedBtnBgColor = UIColor.green
    let selectedBtnTextColor = UIColor.black
    
    var btnState:[Bool] = [false,false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        data = dataController.fun_getDataList()
        showPicker.tintColor = .clear
        createPickerView()
        dismissPickerView()
    }
    
    //tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.textLabel?.text = data[indexPath.row][2]
        cell.detailTextLabel?.text = data[indexPath.row][8]
        
        return cell
    }
    //PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //몇개의 선택 가능한 요소를 둘 것인지
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Picker View에 표시될 항목 개수 반환
        return cityList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return cityList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectCity = cityList[row]
    }
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        showPicker.inputView = pickerView
    }
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.fun_action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        showPicker.inputAccessoryView = toolBar
    }
    @objc func fun_action(){
        showPicker.text = selectCity
        showPicker.resignFirstResponder()
        fun_dataReload()
    }
    func fun_btnToggle(btn:UIButton, state:Bool){
        if state == true{
            btn.tintColor = .white
            btn.backgroundColor = .primary
        }
        else{
            btn.tintColor = notSelectedBtnTextColor
            btn.backgroundColor = notSelectedBtnBgColor
        }
    }
    func fun_dataReload(){
        data = dataController.fun_filterData(city: selectCity, category: btnState)
        tableView.reloadData()
    }
    @IBAction func btnHotelClick(_ sender: CategoryButton) {
        btnState[0] = !btnState[0]
        fun_btnToggle(btn: btnHotel, state: btnState[0])
        fun_dataReload()
    }
    @IBAction func btnMovieClick(_ sender: CategoryButton) {
        btnState[1] = !btnState[1]
        fun_btnToggle(btn: btnMovie, state: btnState[1])
        fun_dataReload()
    }
    
    @IBAction func btnAirplaneClick(_ sender: CategoryButton) {
        btnState[2] = !btnState[2]
        fun_btnToggle(btn: btnAirplane, state: btnState[2])
        fun_dataReload()
    }
    @IBAction func btnRentClick(_ sender: CategoryButton) {
        btnState[3] = !btnState[3]
        fun_btnToggle(btn: btnRent, state: btnState[3])
        fun_dataReload()
    }
    @IBAction func btnMoveClick(_ sender: CategoryButton) {
        btnState[4] = !btnState[4]
        fun_btnToggle(btn: btnMove, state: btnState[4])
        fun_dataReload()
    }
    @IBAction func btnTicketClick(_ sender: CategoryButton) {
        btnState[5] = !btnState[5]
        fun_btnToggle(btn: btnTicket, state: btnState[5])
        fun_dataReload()
    }
    

}

extension UIColor{
    class var darkPrimary:UIColor?{return UIColor(named: "darkPrimary")}
    class var primary:UIColor?{return UIColor(named: "primary")}
}
