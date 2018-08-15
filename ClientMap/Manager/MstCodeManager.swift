//
//  DataManager.swift
//  NoteBook
//
//  Created by vip on 16/11/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import SQLiteSwift3

class MstCodeManager: NSObject {
    class func insert(record: MstCodeModel){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHnadle!.insertData(record.toDictionary(), intoTable: "CodeName")
    }
    
    //コード削除
    class func delete(groupno: String, code:String){
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        DataManager.sqlHnadle?.deleteData("GroupNo='\(groupno)' AND Code='\(code)'", intoTable: "CodeName", isSecurity: false)
    }
    
    //指定種別のコード一覧取得
    class func find(groupno:String)->[MstCodeModel]{
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        
        let request = SQLiteSearchRequest()
        request.contidion = "GroupNo='\(groupno)'"
        var array = Array<MstCodeModel>()
        DataManager.sqlHnadle?.searchData(withReeuest: request, inTable: "CodeName", searchFinish: { (success, dataArray) in
            dataArray?.forEach({ (element) in
                let record = MstCodeModel()
                record.row = element["Row"] as! Int?
                record.grpNo = element["GrpNo"] as! String?
                record.grpName = element["GrpName"] as! String?
                record.code = element["Code"] as! String?
                record.name = element["Name"] as! String?
                array.append(record)
            })
        })
        return array
    }
    
    //指定種別のコード一覧取得
    class func getName(groupno:String, code:String)->String {
        if !DataManager.isOpen {
            DataManager.openDataBase()
        }
        
        let request = SQLiteSearchRequest()
        request.contidion = "GroupNo='\(groupno)' AND Code='\(code)'"
        var array = Array<MstCodeModel>()
        DataManager.sqlHnadle?.searchData(withReeuest: request, inTable: "CodeName", searchFinish: { (success, dataArray) in
            dataArray?.forEach({ (element) in
                let record = MstCodeModel()
                record.row = element["Row"] as! Int?
                record.grpNo = element["GrpNo"] as! String?
                record.grpName = element["GrpName"] as! String?
                record.code = element["Code"] as! String?
                record.name = element["Name"] as! String?
                array.append(record)
            })
        })
        if array.count > 0 {
            return array[0].name!
        }
        return ""
    }
    
    class func createTable(){
        
        let row = SQLiteKeyObject()
        row.name = "Row"
        row.fieldType = INTEGER
        row.modificationType = PRIMARY_KEY
        
        let grpNo = SQLiteKeyObject()
        grpNo.name = "GrpNo"
        grpNo.fieldType = TEXT
        
        let grpName = SQLiteKeyObject()
        grpName.name = "GrpName"
        grpName.fieldType = TEXT
        
        let code = SQLiteKeyObject()
        code.name = "Code"
        code.fieldType = TEXT
        
        let name = SQLiteKeyObject()
        name.name = "Name"
        name.fieldType = TEXT
        
        DataManager.sqlHnadle!.createTable(withName: "CodeName", keys: [row, grpNo, grpName, code, name])
        
    }
    
}
