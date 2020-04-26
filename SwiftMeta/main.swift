//
//  main.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

getInputFilePaths()
    .compactMap(readFile)
    .joined()
    .findMatches(regex: Constants.Regex.Meta, matchIndex: 1)
    .forEach { print($0) }
