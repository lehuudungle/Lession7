//
//  ViewController.swift
//  Lession7
//
//  Created by le.huu.dung on 8/29/18.
//  Copyright © 2018 le.huu.dung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func navigationMovie(_ sender: Any) {
        let button = sender as! UIButton
        if button.tag == 101 {
            let sqlVC = SQLController.init(nibName: "SQLController", bundle: nil)
            self.navigationController?.pushViewController(sqlVC, animated: true)
        } else {
            let coreData = CoreDataController.init(nibName: "CoreDataController", bundle: nil)
            self.navigationController?.pushViewController(coreData, animated: true)
        }
    }

}

