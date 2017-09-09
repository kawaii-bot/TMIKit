//
//  MessageParser.swift
//  TMIKitPackageDescription
//
//  Created by Grant Butler on 9/9/17.
//

import Foundation

struct MessageParseError: Error {
    
    let input: String
    let message: String
    let column: Int
    
}

extension MessageParseError: CustomStringConvertible {
    
    var description: String {
        var lines = Array<String>()
        lines.append(message)
        lines.append(input)
        
        let padding = Array(repeatElement(" ", count: max(column - 10, 0)))
        let prefix = Array(repeatElement("~", count: 9))
        let postfix = Array(repeatElement("~", count: min(max(input.characters.count - column, 0), 5)))
        
        let pointerLine = [
            padding,
            prefix,
            ["^"],
            postfix
        ]
        .flatMap { $0 }
        .joined()
        
        lines.append(pointerLine)
        
        return lines.joined(separator: "\n")
    }
    
}

class MessageParser {
    
    func parse(_ input: String) throws -> Message {
        let builder = MessageBuilder()
        builder.setRaw(input)
        
        let scanner = Scanner(string: input)
        
        if scanner.scanString("@", into: nil) {
            let source = scanner.scanLocation
            
            var rawFoundationMessageTags: NSString?
            guard scanner.scanUpTo(" ", into: &rawFoundationMessageTags) else {
                throw MessageParseError(input: input, message: "Malformed input.", column: source)
            }
            
            guard !scanner.isAtEnd else {
                throw MessageParseError(input: input, message: "Malformed input, only contains tags.", column: source)
            }
            
            guard let rawMessageTags = rawFoundationMessageTags as String? else {
                throw MessageParseError(input: input, message: "Malformed input, expected tags, but didn't parse any.", column: source)
            }
            
            let tags = parseMessageTags(rawMessageTags)
            builder.setTags(tags)
        }
        
        if scanner.scanString(":", into: nil) {
            let source = scanner.scanLocation
            
            var foundationPrefix: NSString?
            guard scanner.scanUpTo(" ", into: &foundationPrefix) else {
                throw MessageParseError(input: input, message: "Malformed input.", column: source)
            }
            
            builder.setPrefix(foundationPrefix as String?)
        }
        
        var foundationCommand: NSString?
        if scanner.scanUpTo(" ", into: &foundationCommand) {
            guard let command = foundationCommand as String?, command.characters.count > 0 else {
                throw MessageParseError(input: input, message: "Malformed input. Expected command, but didn't parse one.", column: scanner.scanLocation)
            }
            
            builder.setCommand(command)
        }
        
        let parameters = try parseParameters(scanner)
        builder.setParameters(parameters)
        
        return builder.build()
        
//        return .chat(
//            channel: "",
//            user: User(
//                username: "",
//                displayName: "",
//                color: "",
//                isSubscriber: false,
//                isTurbo: false,
//                userType: "",
//                badges: [:]
//            ),
//            emotes: [:],
//            message: ""
//        )
    }
    
    private func parseMessageTags(_ input: String) -> [String: String] {
        return input.components(separatedBy: ";")
            .flatMap { (pair) -> (String, String)? in
                let keyValue = pair.components(separatedBy: "=")
                return keyValue.first.map {
                    return ($0, keyValue.last ?? "true")
                }
            }
            .reduce(Dictionary<String, String>(), { (tags, tag) -> [String: String] in
                var mutableTags = tags
                mutableTags[tag.0] = tag.1
                return mutableTags
            })
    }
    
    private func parseParameters(_ scanner: Scanner) throws -> [String] {
        var parameters = Array<String>()
        while !scanner.isAtEnd {
            let source = scanner.scanLocation
            
            var foundationParameter: NSString?
            guard scanner.scanUpTo(" ", into: &foundationParameter) else {
                throw MessageParseError(input: scanner.string, message: "Malformed input, didn't scan parameter.", column: source)
            }
            
            guard let parameter = foundationParameter as String? else {
                throw MessageParseError(input: scanner.string, message: "Malformed input.", column: source)
            }
            
            if parameter.hasPrefix(":") {
                let trimmedParameter = String(parameter.dropFirst())
                let fullParameter = trimmedParameter + scanner.string[scanner.string.index(scanner.string.startIndex, offsetBy: scanner.scanLocation) ..< scanner.string.endIndex]
                parameters.append(fullParameter)
                
                break
            }
            else {
                parameters.append(parameter)
            }
        }
        return parameters
    }
    
}
