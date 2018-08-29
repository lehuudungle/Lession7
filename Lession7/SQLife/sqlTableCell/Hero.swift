//
//  Hero.swift
//  Lession7Demo
//
//  Created by le.huu.dung on 8/29/18.
//  Copyright © 2018 le.huu.dung. All rights reserved.
//

import Foundation

class Hero {
    
    var id: Int
    var name: String?
    var powerRanking: Int
    
    init(id: Int, name: String?, powerRanking: Int){
        self.id = id
        self.name = name
        self.powerRanking = powerRanking
    }
}
