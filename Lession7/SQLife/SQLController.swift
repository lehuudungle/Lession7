//
//  SQLController.swift
//  Lession7Demo
//
//  Created by le.huu.dung on 8/29/18.
//  Copyright © 2018 le.huu.dung. All rights reserved.
//

import UIKit
import SQLite3

class SQLController: UIViewController {
    
    var db: OpaquePointer?
    var heroList = [Hero]()
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPowerRanking: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURL = try! FileManager.default
                            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                            .appendingPathComponent("HeroDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        print("fileUrl: \(fileURL)")
        //creating table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    
    }

    @IBAction func buttonSave(_ sender: Any) {
        //getting values from textfields
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let powerRanking = textFieldPowerRanking.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //validating that values are not empty
        if(name?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(powerRanking?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        //creating a statement
        var stmt: OpaquePointer?
        
        //the insert query
        let queryString = "INSERT INTO Heroes (name, powerrank) VALUES (?,?)"
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //binding the parameters
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, (powerRanking! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        //executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        //emptying the textfields
        textFieldName.text=""
        textFieldPowerRanking.text=""
        
        
        readValues()
        
        //displaying a success message
        print("Herro saved successfully")
    }
    
    func readValues(){
        
        //first empty the list of heroes
        heroList.removeAll()
        
        //this is our select query
        let queryString = "SELECT * FROM Heroes"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let powerrank = sqlite3_column_int(stmt, 2)
            
            //adding values to list
            heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
    }
}
