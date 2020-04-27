//
//  CodeAnalysis.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 27.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

enum Analysis {
    
    static let types: [Type] = [
        Type(isStruct: true, name: "Vector3", members: [
            Property(name: "x", type: "Float", isConstant: true),
            Property(name: "y", type: "Float", isConstant: true),
            Property(name: "z", type: "Float", isConstant: true),
        ])
    ]
    
    static func findType(name: String) -> Type? {
        Analysis.types.first(where: { $0.name == name })
    }
}
