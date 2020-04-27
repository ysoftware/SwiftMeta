//
//  Constants.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

enum Constants {
    
    enum Regex {
        
        static let InputFile = "^SCRIPT_INPUT_FILE_\\d*$"
        static let OutputFile = "^SCRIPT_OUTPUT_FILE_\\d*$"
        static let OneLineComment = "^\\/{2}.*"
        
        // use capture group #1 as the match
        static let Member = "#member[\\(](.*)[\\)]"
        static let Meta = "(?m)(?:^\\s*\\/\\*meta)([\\s\\S]*?\\s*)(?:meta\\*\\/)"
    }
    
    enum Code {
        
        static let types = """
        struct Property {
            let name: String, type: String, isConstant: Bool
        }
        struct Method {
            let isStatis: Bool, isThrowing: Bool, name: String, arguments: [Property], outputType: String
        }
        struct Type {
            let isStruct: Bool, name: String, members: [Property]
            func printMembers() -> String {
                return "[" + members.map { value in "Property(name: \\"\\(value.name)\\", type: \\"\\(value.type)\\", isConstant: \\(value.isConstant ? "true" : "false"))" }.joined(separator: ", ") + "]"
            }
        }
        """
    }
}
