//
//  main.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

let paths = getInputFilePaths()
let files = paths.compactMap { readFile(at: $0) }
let descriptors = files.map { getMetaMatches(string: $0.contents, path: $0.path) }.flatMap { $0 }
let preprocessedDescriptors = descriptors.map(processDirectives)

writeChanges(preprocessedDescriptors)


// @Incomplete restore original file after compilation
