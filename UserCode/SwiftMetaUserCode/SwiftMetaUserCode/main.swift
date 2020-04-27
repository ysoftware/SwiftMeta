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


struct SOA_Vector3 {
/*meta
    var string = ""
    for member in #member(Vector3) {
        string += "\tvar \(member.name): [\(member.type)] = []\n"
    }
    return string
meta*/
}
