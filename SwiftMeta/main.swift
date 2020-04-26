//
//  main.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

struct MatchDescriptor {
    
    let location: Int
    let path: String
    let code: String
    let compiledCode: String
}

let paths = getInputFilePaths()

let files = paths.compactMap { readFile(at: $0) }
let descriptors = files.map { getMetaMatches(string: $0.contents, path: $0.path) }.flatMap { $0 }

descriptors.forEach { d in
    
    guard let (_, originalContents) = readFile(at: d.path) else { return }
    
    var newContents = originalContents
    let index = originalContents.index(originalContents.startIndex, offsetBy: d.location)
    newContents.insert(contentsOf: "\n" + d.compiledCode, at: index)
    
    // @Incomplete save original file
    
    write(to: d.path, contents: newContents)
}


// @Incomplete restore original file after compilation
