//
//  CoreDataController.swift
//  Lession7Demo
//
//  Created by le.huu.dung on 8/29/18.
//  Copyright © 2018 le.huu.dung. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: UIViewController {

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtTenKH: UITextField!
    @IBOutlet weak var txtTuoiKH: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func btnInsert(_ sender: Any) {
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let newKH = NSEntityDescription.insertNewObject(forEntityName: "KhachHang", into: context)
        //        let entity = NSEntityDescription.entity(forEntityName: "KhachHang", in: context)
        //        let newKH = NSManagedObject(entity: entity!, insertInto: context)
        newKH.setValue(Int(txtId.text!), forKey: "id")
        newKH.setValue(txtTenKH.text!, forKey: "tenKH")
        newKH.setValue(Int(txtTuoiKH.text!), forKey: "tuoiKH")
        do {
            try context.save()
        } catch  {
            print("insert error !!!")
        }
    }
    
   

}
