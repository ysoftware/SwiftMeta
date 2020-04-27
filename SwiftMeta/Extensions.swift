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

func getMatches(string: String, regex: String) -> [NSTextCheckingResult] {
    let range = NSRange(location: 0, length: string.utf16.count)
    let regex = try! NSRegularExpression(pattern: regex)
    return regex.matches(in: string, options: [], range: range)
}

func getMetaMatches(string: String, path: String) -> [MatchDescriptor] {
    
    var array: [MatchDescriptor] = []
    let results = getMatches(string: string, regex: Constants.Regex.Meta)
    
    results.forEach { match in
        guard let range = Range(match.range(at: 1), in: string) else { return }
        let code = String(string[range])
        array.append(MatchDescriptor(code: code, range: Range(match.range, in: string)!,
                                     path: path, compiledCode: nil))
    }
    return array
}

func processDirectives(_ descriptor: MatchDescriptor) -> MatchDescriptor {
    
    var updatedDescriptor = descriptor
    
    // check for #members directive
    let membersMatches = getMatches(string: descriptor.code, regex: Constants.Regex.Member)
    for match in membersMatches {
        
        guard let range = Range(match.range(at: 1), in: descriptor.code) else { continue }
        let fullRange = Range(match.range, in: descriptor.code)!
        let type = String(descriptor.code[range])
        guard let printedOutMembers = Analysis.findType(name: type)?.printMembers() else {
            
            continue
            // fail with error
            // "Can't find type \(type) at \(line)"
        }
        updatedDescriptor.code.replaceSubrange(fullRange, with: printedOutMembers)
    }
    
//    print("preparing to compile body: ...")
//    print(updatedDescriptor.code)
//    print("----- \n\n\n")
    updatedDescriptor.compiledCode = compile(string: wrapIntoFunction(updatedDescriptor.code))
    
    return updatedDescriptor
}

func writeChanges(_ descriptors: [MatchDescriptor]) {
    
    descriptors.forEach { d in
        guard let (_, originalContents) = readFile(at: d.path) else { return }
        guard let compiledCode = d.compiledCode?.trimmingCharacters(in: .newlines) else { return }
        
        var newContents = originalContents
        newContents.replaceSubrange(d.range, with: compiledCode)
        
        // @Incomplete save changes
        
        print(newContents)
        
//        write(to: d.path, contents: newContents)
    }
}
