//
//  MessageParserTests.swift
//  TMIKitTests
//
//  Created by Grant Butler on 9/9/17.
//

import XCTest
@testable import TMIKit

class MessageParserTests: XCTestCase {
    
    let parser = MessageParser()
    
    func testActionParsing() {
        let raw = "@badges=broadcaster/1,warcraft/horde;color=#0D4200;display-name=Schmoopiie;emotes=25:0-4,12-16/1902:6-10;subscriber=0;turbo=1;user-type=global_mod :schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv PRIVMSG #schmoopiie :\u{0001}ACTION Hello :)\u{0001}"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "broadcaster/1,warcraft/horde",
                "color": "#0D4200",
                "display-name": "Schmoopiie",
                "emotes": "25:0-4,12-16/1902:6-10",
                "subscriber": "0",
                "turbo": "1",
                "user-type": "global_mod"
            ],
            prefix: "schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "PRIVMSG",
            parameters: [
                "#schmoopiie",
                "\u{0001}ACTION Hello :)\u{0001}"
            ]
        ), message)
    }
    
    func testBanParsing() {
        let raw = "@ban-reason=this\\sis\\sa\\stest :tmi.twitch.tv CLEARCHAT #schmoopiie :schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "ban-reason": "this\\sis\\sa\\stest",
            ],
            prefix: "tmi.twitch.tv",
            command: "CLEARCHAT",
            parameters: [
                "#schmoopiie",
                "schmoopiie"
            ]
        ), message)
    }
    
    func testChatParsing() {
        let raw = "@badges=broadcaster/1,warcraft/horde;color=#0D4200;display-name=Schmoopiie;emotes=25:0-4,12-16/1902:6-10;subscriber=0;turbo=1;user-type=global_mod :schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv PRIVMSG #schmoopiie :Hello :)"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "broadcaster/1,warcraft/horde",
                "color": "#0D4200",
                "display-name": "Schmoopiie",
                "emotes": "25:0-4,12-16/1902:6-10",
                "subscriber": "0",
                "turbo": "1",
                "user-type": "global_mod"
            ],
            prefix: "schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "PRIVMSG",
            parameters: [
                "#schmoopiie",
                "Hello :)"
            ]
        ), message)
    }
    
    func testCheerParsing() {
        let raw = "@badges=broadcaster/1,warcraft/horde;color=#0D4200;bits=100;display-name=Schmoopiie;emotes=;subscriber=0;turbo=1;user-type=global_mod :schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv PRIVMSG #schmoopiie :cheer100 Hello :)"
        let message = try! parser.parse(raw)
    
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "broadcaster/1,warcraft/horde",
                "bits": "100",
                "color": "#0D4200",
                "display-name": "Schmoopiie",
                "emotes": "",
                "subscriber": "0",
                "turbo": "1",
                "user-type": "global_mod"
            ],
            prefix: "schmoopiie!~schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "PRIVMSG",
            parameters: [
                "#schmoopiie",
                "cheer100 Hello :)"
            ]
        ), message)
    }
    
    func testClearChatParsing() {
        let raw = ":tmi.twitch.tv CLEARCHAT #schmoopiie"
        let message = try! parser.parse(raw)
    
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "tmi.twitch.tv",
            command: "CLEARCHAT",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testConnectedParsing() {
        let raw = ":tmi.twitch.tv 372 schmoopiie :You are in a maze of twisty passages, all alike."
        let message = try! parser.parse(raw)
    
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "tmi.twitch.tv",
            command: "372",
            parameters: [
                "schmoopiie",
                "You are in a maze of twisty passages, all alike."
            ]
        ), message)
    }
    
    func testEmoteSetsParsing() {
        let raw = "@color=#1E90FF;display-name=Schmoopiie;emote-sets=0;turbo=0;user-type= :tmi.twitch.tv GLOBALUSERSTATE"
        let message = try! parser.parse(raw)
    
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "color": "#1E90FF",
                "display-name": "Schmoopiie",
                "emote-sets": "0",
                "turbo": "0",
                "user-type": ""
            ],
            prefix: "tmi.twitch.tv",
            command: "GLOBALUSERSTATE",
            parameters: []
        ), message)
    }
    
    func testHostedParsing() {
        let raw = ":jtv!~jtv@jtv.tmi.twitch.tv PRIVMSG #schmoopiie :Username is now hosting you for 11 viewers."
        let message = try! parser.parse(raw)
    
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "jtv!~jtv@jtv.tmi.twitch.tv",
            command: "PRIVMSG",
            parameters: [
                "#schmoopiie",
                "Username is now hosting you for 11 viewers."
            ]
        ), message)
    }
    
    func testHostingParsing() {
        let raw = ":tmi.twitch.tv HOSTTARGET #schmoopiie :schmoopiie 3"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "tmi.twitch.tv",
            command: "HOSTTARGET",
            parameters: [
                "#schmoopiie",
                "schmoopiie 3"
            ]
        ), message)
    }
    
    func testJoinParsing() {
        let raw = ":schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv JOIN #schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "JOIN",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testModParsing() {
        let raw = ":jtv MODE #schmoopiie +o schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "jtv",
            command: "MODE",
            parameters: [
                "#schmoopiie",
                "+o",
                "schmoopiie"
            ]
        ), message)
    }
    
    func testModsParsing() {
        let raw = "@msg-id=room_mods :tmi.twitch.tv NOTICE #schmoopiie :The moderators of this room are: user1, user2, user3"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "msg-id": "room_mods"
            ],
            prefix: "tmi.twitch.tv",
            command: "NOTICE",
            parameters: [
                "#schmoopiie",
                "The moderators of this room are: user1, user2, user3"
            ]
        ), message)
    }
    
    func testPartParsing() {
        let raw = ":schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv PART #schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "PART",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testPingParsing() {
        let raw = "PING :tmi.twitch.tv"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: nil,
            command: "PING",
            parameters: [
                "tmi.twitch.tv"
            ]
        ), message)
    }
    
    func testPongParsing() {
        let raw = "PONG :tmi.twitch.tv"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: nil,
            command: "PONG",
            parameters: [
                "tmi.twitch.tv"
            ]
        ), message)
    }
    
    func testR9KBetaOnParsing() {
        let raw = "@msg-id=r9k_on :tmi.twitch.tv NOTICE #schmoopiie :This room is now in r9k mode."
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "msg-id": "r9k_on"
            ],
            prefix: "tmi.twitch.tv",
            command: "NOTICE",
            parameters: [
                "#schmoopiie",
                "This room is now in r9k mode."
            ]
        ), message)
    }
    
    func testR9KBetaOffParsing() {
        let raw = "@msg-id=r9k_off :tmi.twitch.tv NOTICE #schmoopiie :This room is no longer in r9k mode."
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "msg-id": "r9k_off"
            ],
            prefix: "tmi.twitch.tv",
            command: "NOTICE",
            parameters: [
                "#schmoopiie",
                "This room is no longer in r9k mode."
            ]
        ), message)
    }
    
    func testRoomStateParsing() {
        let raw = "@broadcaster-lang=;r9k=0;slow=0;subs-only=0 :tmi.twitch.tv ROOMSTATE #schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "broadcaster-lang": "",
                "r9k": "0",
                "slow": "0",
                "subs-only": "0"
            ],
            prefix: "tmi.twitch.tv",
            command: "ROOMSTATE",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testSlowModeOnParsing() {
        let raw = "@slow=8 :tmi.twitch.tv ROOMSTATE #schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "slow": "8",
            ],
            prefix: "tmi.twitch.tv",
            command: "ROOMSTATE",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testSlowModeOffParsing() {
        let raw = "@slow=0 :tmi.twitch.tv ROOMSTATE #schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "slow": "0",
            ],
            prefix: "tmi.twitch.tv",
            command: "ROOMSTATE",
            parameters: [
                "#schmoopiie"
            ]
        ), message)
    }
    
    func testSubAnniversaryParsing() {
        let raw = "@badges=staff/1,subscriber/6,turbo/1;color=#008000;display-name=Schmoopiie;emotes=;mod=0;msg-id=resub;msg-param-months=6;room-id=20624989;subscriber=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Channel\\sSubscription\\s(Schmoopiie);system-msg=Schmoopiie\\shas\\ssubscribed\\sfor\\s6\\smonths!;login=schmoopiie;turbo=1;user-id=20624989;user-type=staff :tmi.twitch.tv USERNOTICE #schmoopiie :Great stream -- keep it up!"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "staff/1,subscriber/6,turbo/1",
                "color": "#008000",
                "display-name": "Schmoopiie",
                "emotes": "",
                "mod": "0",
                "msg-id": "resub",
                "msg-param-months": "6",
                "room-id": "20624989",
                "subscriber": "1",
                "msg-param-sub-plan": "Prime",
                "msg-param-sub-plan-name": "Channel\\sSubscription\\s(Schmoopiie)",
                "system-msg": "Schmoopiie\\shas\\ssubscribed\\sfor\\s6\\smonths!",
                "login": "schmoopiie",
                "turbo": "1",
                "user-id": "20624989",
                "user-type": "staff"
            ],
            prefix: "tmi.twitch.tv",
            command: "USERNOTICE",
            parameters: [
                "#schmoopiie",
                "Great stream -- keep it up!"
            ]
        ), message)
    }
    
    func testResubParsing() {
        let raw = "@badges=staff/1,subscriber/6,turbo/1;color=#008000;display-name=Schmoopiie;emotes=;mod=0;msg-id=resub;msg-param-months=6;room-id=20624989;subscriber=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Channel\\sSubscription\\s(Schmoopiie);system-msg=Schmoopiie\\shas\\ssubscribed\\sfor\\s6\\smonths!;login=schmoopiie;turbo=1;user-id=20624989;user-type=staff :tmi.twitch.tv USERNOTICE #schmoopiie :Great stream -- keep it up!"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "staff/1,subscriber/6,turbo/1",
                "color": "#008000",
                "display-name": "Schmoopiie",
                "emotes": "",
                "mod": "0",
                "msg-id": "resub",
                "msg-param-months": "6",
                "room-id": "20624989",
                "subscriber": "1",
                "msg-param-sub-plan": "Prime",
                "msg-param-sub-plan-name": "Channel\\sSubscription\\s(Schmoopiie)",
                "system-msg": "Schmoopiie\\shas\\ssubscribed\\sfor\\s6\\smonths!",
                "login": "schmoopiie",
                "turbo": "1",
                "user-id": "20624989",
                "user-type": "staff"
            ],
            prefix: "tmi.twitch.tv",
            command: "USERNOTICE",
            parameters: [
                "#schmoopiie",
                "Great stream -- keep it up!"
            ]
        ), message)
    }
    
    func testSubscriberOnlyModeOnParsing() {
        let raw = "@msg-id=subs_on :tmi.twitch.tv NOTICE #schmoopiie :This room is now in subscribers-only mode."
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "msg-id": "subs_on",
            ],
            prefix: "tmi.twitch.tv",
            command: "NOTICE",
            parameters: [
                "#schmoopiie",
                "This room is now in subscribers-only mode."
            ]
        ), message)
    }
    
    func testSubscriberOnlyModeOffParsing() {
        let raw = "@msg-id=subs_off :tmi.twitch.tv NOTICE #schmoopiie :This room is no longer in subscribers-only mode."
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "msg-id": "subs_off",
            ],
            prefix: "tmi.twitch.tv",
            command: "NOTICE",
            parameters: [
                "#schmoopiie",
                "This room is no longer in subscribers-only mode."
            ]
        ), message)
    }
    
    func testSubscribeParsing() {
        let raw = "@badges=staff/1,subscriber/1,turbo/1;color=#008000;display-name=Schmoopiie;emotes=;mod=0;msg-id=sub;room-id=20624989;subscriber=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Channel\\sSubscription\\s(Schmoopiie);system-msg=Schmoopiie\\sjust\\ssubscribed!;login=schmoopiie;turbo=1;user-id=20624989;user-type=staff :tmi.twitch.tv USERNOTICE #schmoopiie :Great stream -- keep it up!"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "badges": "staff/1,subscriber/1,turbo/1",
                "color": "#008000",
                "display-name": "Schmoopiie",
                "emotes": "",
                "mod": "0",
                "msg-id": "sub",
                "room-id": "20624989",
                "subscriber": "1",
                "msg-param-sub-plan": "Prime",
                "msg-param-sub-plan-name": "Channel\\sSubscription\\s(Schmoopiie)",
                "system-msg": "Schmoopiie\\sjust\\ssubscribed!",
                "login": "schmoopiie",
                "turbo": "1",
                "user-id": "20624989",
                "user-type": "staff"
            ],
            prefix: "tmi.twitch.tv",
            command: "USERNOTICE",
            parameters: [
                "#schmoopiie",
                "Great stream -- keep it up!"
            ]
        ), message)
    }
    
    func testTimeoutParsing() {
        let raw = "@ban-duration=60;ban-reason=this\\sis\\sa\\stest :tmi.twitch.tv CLEARCHAT #schmoopiie :schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "ban-duration": "60",
                "ban-reason": "this\\sis\\sa\\stest",
            ],
            prefix: "tmi.twitch.tv",
            command: "CLEARCHAT",
            parameters: [
                "#schmoopiie",
                "schmoopiie"
            ]
        ), message)
    }
    
    func testUnhostParsing() {
        let raw = ":tmi.twitch.tv HOSTTARGET #schmoopiie :- 0"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "tmi.twitch.tv",
            command: "HOSTTARGET",
            parameters: [
                "#schmoopiie",
                "- 0"
            ]
        ), message)
    }
    
    func testUnModParsing() {
        let raw = ":jtv MODE #schmoopiie -o schmoopiie"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [:],
            prefix: "jtv",
            command: "MODE",
            parameters: [
                "#schmoopiie",
                "-o",
                "schmoopiie"
            ]
        ), message)
    }
    
    func testWhisperParsing() {
        let raw = "@color=#FFFFFF;display-name=Schmoopiie;emotes=;turbo=1;user-type= :schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv WHISPER martinlarouche :Hello! ;-)"
        let message = try! parser.parse(raw)
        
        XCTAssertEqual(Message(
            raw: raw,
            tags: [
                "color": "#FFFFFF",
                "display-name": "Schmoopiie",
                "emotes": "",
                "turbo": "1",
                "user-type": ""
            ],
            prefix: "schmoopiie!schmoopiie@schmoopiie.tmi.twitch.tv",
            command: "WHISPER",
            parameters: [
                "martinlarouche",
                "Hello! ;-)"
            ]
        ), message)
    }
    
}
