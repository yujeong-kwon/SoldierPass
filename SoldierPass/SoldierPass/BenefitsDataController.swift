//
//  BenefitsDataController.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/02.
//

import Foundation

class BenefitsDataController{
    private var dataList:[[String]]
    
    init(){
        dataList = []
    }
    func fun_isEmpty()->Bool{
        if dataList.count == 0{
            return true
        }
        else{
            return false
        }
    }
    func fun_getDataList()->[[String]]{
        return dataList
    }
    func fun_loadDataFromCSV(){
        let path = Bundle.main.path(forResource: "data", ofType: "csv")!;
        fun_parseCSVAt(url: URL(fileURLWithPath: path))
    }
    private func fun_parseCSVAt(url:URL){
        do{
            let data = try Data(contentsOf: url);
            let dataEncoded = String(data:data, encoding: .utf8);
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}){
                for item in dataArr{
                    dataList.append(item)
                }
            }
        }catch{
            print("Error reading CSV file");
        }
    }
}

