//
//  File.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import Foundation

struct ElevatorMessage: Codable, Hashable {
    enum MessageSource: Int, Codable {
        case App
        case User
    }
    var source: MessageSource = MessageSource.App
    var text: String = ""
}

struct Elevator: Codable, Identifiable {
    enum ElevatorStatus: Int, Codable {
        case Level
        case BottomInit
        case BottomFinal
        case Complete
    }
    let id = UUID()
    var messages: [ElevatorMessage]
    var state: ElevatorStatus
//    var tags: [String]
}
