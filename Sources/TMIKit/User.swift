//
//  User.swift
//  TMIKitPackageDescription
//
//  Created by Grant Butler on 9/9/17.
//

public struct User {
    
    public let username: String
    public let displayName: String
    public let color: String // TODO: Turn this into an actual color object?
    public let isSubscriber: Bool
    public let isTurbo: Bool // TODO: Turn isTurbo/isSubscriber into an option set?
    public let userType: String // TODO: Turn this into an enum?
    public let badges: [String: String]
    
    public init(username: String, displayName: String, color: String, isSubscriber: Bool, isTurbo: Bool, userType: String, badges: [String: String]) {
        self.username = username
        self.displayName = displayName
        self.color = color
        self.isSubscriber = isSubscriber
        self.isTurbo = isTurbo
        self.userType = userType
        self.badges = badges
    }
    
}

extension User: Equatable {
    
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
    
}
