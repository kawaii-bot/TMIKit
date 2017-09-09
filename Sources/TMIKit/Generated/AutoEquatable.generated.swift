// Generated using Sourcery 0.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}

fileprivate func compareDictionaries<T, U>(lhs: [T: U], rhs: [T: U], compare: (_ lhs: U, _ rhs: U) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    guard lhs.keys == rhs.keys else { return false }
    for key in lhs.keys {
        guard let lhsItem = lhs[key] else { return false }
        guard let rhsItem = rhs[key] else { return false }
        guard compare(lhsItem, rhsItem) else { return false }
    }
    return true
}



// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Message AutoEquatable
extension Message: Equatable {}
internal func == (lhs: Message, rhs: Message) -> Bool {
    guard lhs.raw == rhs.raw else { return false }
    guard lhs.tags == rhs.tags else { return false }
    guard compareOptionals(lhs: lhs.prefix, rhs: rhs.prefix, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.command, rhs: rhs.command, compare: ==) else { return false }
    guard lhs.parameters == rhs.parameters else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
