//
//  Model.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 27.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

struct MatchDescriptor {
    
    var code: String
    let range: Range<String.Index>
    let path: String
    var compiledCode: String?
}


struct Property {
    let name: String, type: String, isConstant: Bool
}
struct Method {
    let isStatis: Bool, isThrowing: Bool, name: String, arguments: [Property], outputType: String
}
struct Type {
    let isStruct: Bool, name: String, members: [Property]
    func printMembers() -> String {
        return "[" + members.map { value in "Property(name: \"\(value.name)\", type: \"\(value.type)\", isConstant: \(value.isConstant ? "true" : "false"))" }.joined(separator: ", ") + "]"
    }
}
