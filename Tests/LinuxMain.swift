// Generated using Sourcery 0.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable import TMIKitTests
extension MessageParserTests {
  static var allTests: [(String, (MessageParserTests) -> () throws -> Void)] = [
    ("testActionParsing", testActionParsing),
    ("testBanParsing", testBanParsing),
    ("testChatParsing", testChatParsing),
    ("testCheerParsing", testCheerParsing),
    ("testClearChatParsing", testClearChatParsing),
    ("testConnectedParsing", testConnectedParsing),
    ("testEmoteSetsParsing", testEmoteSetsParsing),
    ("testHostedParsing", testHostedParsing),
    ("testHostingParsing", testHostingParsing),
    ("testJoinParsing", testJoinParsing),
    ("testModParsing", testModParsing),
    ("testModsParsing", testModsParsing),
    ("testPartParsing", testPartParsing),
    ("testPingParsing", testPingParsing),
    ("testPongParsing", testPongParsing),
    ("testR9KBetaOnParsing", testR9KBetaOnParsing),
    ("testR9KBetaOffParsing", testR9KBetaOffParsing),
    ("testRoomStateParsing", testRoomStateParsing),
    ("testSlowModeOnParsing", testSlowModeOnParsing),
    ("testSlowModeOffParsing", testSlowModeOffParsing),
    ("testSubAnniversaryParsing", testSubAnniversaryParsing),
    ("testResubParsing", testResubParsing),
    ("testSubscriberOnlyModeOnParsing", testSubscriberOnlyModeOnParsing),
    ("testSubscriberOnlyModeOffParsing", testSubscriberOnlyModeOffParsing),
    ("testSubscribeParsing", testSubscribeParsing),
    ("testTimeoutParsing", testTimeoutParsing),
    ("testUnhostParsing", testUnhostParsing),
    ("testUnModParsing", testUnModParsing),
    ("testWhisperParsing", testWhisperParsing)
  ]
}
extension TMIKitTests {
  static var allTests: [(String, (TMIKitTests) -> () throws -> Void)] = [
    ("testExample", testExample)
  ]
}

// swiftlint:disable trailing_comma
XCTMain([
  testCase(MessageParserTests.allTests),
  testCase(TMIKitTests.allTests),
])
// swiftlint:enable trailing_comma
