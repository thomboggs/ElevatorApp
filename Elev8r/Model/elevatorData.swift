//
//  File.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import Foundation

struct ElevatorMessage: Codable, Identifiable {
    enum MessageSource: Int, Codable {
        case App
        case User
    }
    var id: UInt = 0
    var source: MessageSource = MessageSource.App
    var text: String = ""
}

struct Elevator: Codable, Identifiable {
    enum ElevatorStatus: Int, Codable {
        case Top
        case Level
        case BottomInit
        case BottomFinal
        case Complete
    }
    var id: UInt
    var messages: [ElevatorMessage]
    var state: ElevatorStatus
    var stepCount: UInt = 1
//    var tags: [String]
}
