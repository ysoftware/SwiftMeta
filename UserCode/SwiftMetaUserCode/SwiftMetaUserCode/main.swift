//
//  main.swift
//  SwiftMetaUserCode
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

struct Vector3 {
    
    var x: Float
    var y: Float
    var z: Float
}


func printMembers(of type: Vector3) {
    /*meta
    return ["x", "y", "z"].reduce(into: "") {
        $0 += "print(\"\($1)\")\n"
    }
    meta*/
}
