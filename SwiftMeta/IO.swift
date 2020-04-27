//
//  IO.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

// @Incomplete issue warnings for 'file not found' errors?
func readFile(at path: String) -> (path: String, contents: String)? {
    let url = URL(fileURLWithPath: path, relativeTo: URL(string: "\\"))
    guard let contents = try? String(contentsOf: url, encoding: .utf8) else { return nil }
    return (path, contents)
}

func write(to path: String, contents: String) {
    let url = URL(fileURLWithPath: path, relativeTo: URL(string: "\\"))
    try? contents.write(to: url, atomically: true, encoding: .utf8)
}

func getInputFilePaths() -> [String] {
    ProcessInfo.processInfo.environment
        .filter { $0.key.isMatching(Constants.Regex.InputFile) }
        .map(\.value)
}

func wrapIntoFunction(_ code: String) -> String {
    let program = """
    \(Constants.Code.types)
    func run() -> String {
    \(code)
    }
    print(run())
    """
    return program
}

func compile(string: String) -> String {
    print("compiling: ...")
    print(string)
    print("-----\n\n")
    
    return (try? throwingCompile(string: string)) ?? ""
}

// @Safety do error checking
func throwingCompile(string: String) throws -> String {
    
    let path = FileManager.default.currentDirectoryPath
    
    // write file to disk
    let url = URL(fileURLWithPath: path).appendingPathComponent("file.swift")
    try string.write(to: url, atomically: true, encoding: .utf8)
    
    // setup
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
    task.arguments = [url.path]
    let outputPipe = Pipe()
    task.standardOutput = outputPipe
    
    // run swift
    try task.run()
    task.waitUntilExit()
    
    // get the output
    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: outputData, as: UTF8.self)
    
    // remove the file
    try? FileManager.default.removeItem(atPath: url.path)
    
    return output
}
