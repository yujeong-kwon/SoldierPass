//
//  DBHelper.swift
//  SoldierPass
//
//  Created by 방유빈 on 2022/08/16.
//

import Foundation
import SQLite3

class DBHelper{
    static let shared = DBHelper()
    var db:OpaquePointer?
    var path = "mySqlite.sqlite"
    
    init(){
        self.db = createDB()
        createTable()
    }
    
    func createDB()->OpaquePointer?{
        var db : OpaquePointer? = nil
        do {
                
                //appendingPathExtension(path)은 플레이그라운드에서는 되지만 실제 APP에서는 되지 않았다.
                //따라서 이렇게 변경해줘야한다. appendingPathExtension(path) -> appendingPathComponent(path)
        let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
                    
            if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                print("Succesfully create Database path : \(filePath.path)")
                return db
            }
            
        }
        catch{
            print("ERROR in CreateDB - \(error.localizedDescription)")
        }
                
        print("ERROR in CreateDB - sqlite3_open ")
        return nil
                
    }
    func createTable(){
            //AUTOINCREMENT를 사용하기 위해서는 INT 가 아니라 INTEGER을 사용해야 한다.
        let query = "create table if not exists myDB(id INT);"
            
        var statement : OpaquePointer? = nil
            
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Create Table SuccessFully \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n Create Table step fail :  \(errorMessage)")
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n create Table sqlite3_prepare Fail ! :\(errorMessage)")
                
        }

        sqlite3_finalize(statement)
    }
    
    func deleteTable(){
        let query = "DROP TABLE myDB"
            
        var statement : OpaquePointer? = nil
            
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete Table SuccessFully \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n Delete Table step fail ! : \(errorMessage)")
                
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n delete Table prepare fail! : \(errorMessage)")
                
        }
    
        sqlite3_finalize(statement)
    }
    
    func insertData(idx:Int){
            
            //autocrement일 경우에는 입력 부분에서는 컬럼을 추가 안해줘도 자동으로 추가가 되지만
            //쿼리 문에서는 이렇게 추가 해줘야합니다.
       
        let query = "insert into myDB values (?);"
        var statement : OpaquePointer? = nil
            
        do {
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_int(statement, 1, Int32(idx))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Insert data SuccessFully : \(String(describing: db))")
                }
                else{
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("\n insert Data sqlite3 step fail! : \(errorMessage)")
                }
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n insert Data prepare fail! : \(errorMessage)")
            }
                
            
            sqlite3_finalize(statement)
                
            }
        catch{
            print("JSONEncoder Error : \(error.localizedDescription)")
        }
    }
    
    func deleteData(idx:String){
        //let query = "delete from myDB where 'id'=\(idx);"
        let query = "delete from myDB;"
            
        var statement : OpaquePointer? = nil
        print(query)
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing delete: v1\(errMsg)")
            return
        }
                
        if sqlite3_step(statement) != SQLITE_DONE {
            let errMsg = String(cString : sqlite3_errmsg(db)!)
            print("delete fail :: \(errMsg)")
            return
        }
        sqlite3_finalize(statement)
                        
        }
    
    func fun_selectAll()->Array<Int>{
        var result:Array<Int>=[]
        let query = "select * from myDB;"
        
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW{
                let idx = sqlite3_column_int(statement, 0)
                
                result.append(Int(idx))
            }
            
        }
        else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n read Data prepare fail! : \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        return result
    }

}
