//
//  Extensions.swift
//  SwiftMeta
//
//  Created by Ерохин Ярослав Игоревич on 26.04.2020.
//  Copyright © 2020 Yaroslav Erokhin. All rights reserved.
//

import Foundation

extension String {
    
    func isMatching(_ regex: String) -> Bool {
        let range = NSRange(location: 0, length: utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func findMatches(regex: String, matchIndex: Int = 0) -> [String] {
        let range = NSRange(location: 0, length: utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        let results = regex.matches(in: self, options: [], range: range)
        
        return results.compactMap {
            guard let range = Range($0.range(at: matchIndex), in: self) else { return nil }
            return String(self[range])
        }
    }
}

func getMetaMatches(string: String, path: String) -> [MatchDescriptor] {
    
    var array: [MatchDescriptor] = []
    let range = NSRange(location: 0, length: string.utf16.count)
    let regex = try! NSRegularExpression(pattern: Constants.Regex.Meta)
    let results = regex.matches(in: string, options: [], range: range)
    
    results.forEach { match in
        guard let range = Range(match.range(at: 1), in: string) else { return }
        let location = match.range.location-1
        let code = String(string[range])
        let compiledCode = compile(string: wrapIntoFunction(code))
        array.append(MatchDescriptor(location: location, path: path,
                                     code: code, compiledCode: compiledCode))
    }
    return array
}
