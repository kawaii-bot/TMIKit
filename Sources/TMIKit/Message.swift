//
//  Message.swift
//  TMIKitPackageDescription
//
//  Created by Grant Butler on 9/9/17.
//

//public enum Message {
//
//
//    case chat(channel: String, user: User, /* sourcery: dictionaryEquality */emotes: [String: [String]], message: String)
//
//}
//
//extension Message: AutoEquatable {}

struct Message {
    
    let raw: String
    let tags: [String: String]
    let prefix: String?
    let command: String?
    let parameters: [String]
    
}

extension Message: AutoEquatable {}
extension Message: AutoBuilder {}
