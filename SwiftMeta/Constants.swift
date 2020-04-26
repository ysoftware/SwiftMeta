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
        static let Meta = "(?m)(?:^\\s*\\/\\*meta)([\\s\\S]*?\\s*)(?:meta\\*\\/)"
    }
}
