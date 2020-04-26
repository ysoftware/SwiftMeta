//
//  IO.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

// @Incomplete issue warnings for 'file not found' errors?
func readFile(of path: String) -> String? {
    let url = URL(fileURLWithPath: path, relativeTo: URL(string: "\\"))
    guard let contents = try? String(contentsOf: url, encoding: .utf8) else { return nil }
    return contents
}

func getInputFilePaths() -> [String] {
    ProcessInfo.processInfo.environment
        .filter { $0.key.isMatching(Constants.Regex.InputFile) }
        .map(\.value)
}

// @Safety do error checking
func compile(string: String) -> String {
    let task = Process()
    task.launchPath = "/usr/bin/swift"
    let outpipe = Pipe()
    let inpipe = Pipe()
    inpipe.fileHandleForWriting.write(string.data(using: String.Encoding.utf8, allowLossyConversion: true)!)
    task.standardInput = inpipe
    task.standardOutput = outpipe
    task.launch()
    task.waitUntilExit()
    task.standardInput = Pipe()
    let data = outpipe.fileHandleForReading.readDataToEndOfFile()
    let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    return output
}
