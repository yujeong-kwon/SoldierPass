//
//  BenefitsDataController.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/02.
//

import Foundation

var dataList:[[String]]=[]

class BenefitsDataController{
    
    init(){
        dataList=[]
        fun_loadDataFromCSV()
    }
    func fun_isEmpty()->Bool{
        if dataList.count == 0{
            return true
        }
        else{
            return false
        }
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
                for (index,item) in dataArr.enumerated(){
                    if index == 0{
                        continue
                    }
                    var data:[String] = []
                    data.append(String(index-1))
                    data.append(item[2])
                    data.append(item[1])
                    data.append(item[9])
                    data.append(item[8])
                    data.append(item[6])
                    data.append(item[7])
                    data.append(item[10])
                    
                    dataList.append(data)
                }
            }
        }catch{
            print("Error reading CSV file");
        }
        print(dataList.count)
    }
    func fun_filterData(city:String,category:[Bool])->[[String]]{
        var data:[[String]]=[]
        if city == "전국"{
            data = dataList
        }
        else{
            for item in dataList{
                if item[1] == city {
                    data.append(item)
                }
            }
        }
        var data2:[[String]]=[]
        if category == [false,false,false,false,false,false]{
            return data
        }
        
        if category[0] == true {
            for item in data{
                if item[3] == "숙박" {
                    data2.append(item)
                }
            }
        }
        if category[1] == true {
            for item in data{
                if item[3] == "영화" {
                    data2.append(item)
                }
            }
        }
        if category[2] == true {
            for item in data{
                if item[3] == "항공" {
                    data2.append(item)
                }
            }
        }
        if category[3] == true {
            for item in data{
                if item[3] == "렌트" {
                    data2.append(item)
                }
            }
        }
        if category[4] == true {
            for item in data{
                if item[3] == "이사" {
                    data2.append(item)
                }
            }
        }
        if category[5] == true {
            for item in data{
                if item[3] == "이용권" {
                    data2.append(item)
                }
            }
        }
        return data2
    }
}

