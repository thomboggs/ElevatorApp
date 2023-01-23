//
//  File.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import Foundation

struct ElevatorStep: Codable, Identifiable {
    enum ElevatorStepType: Int, Codable {
        case Top
        case Level
        case BottomInit
        case BottomFinal
    }
    var id: UInt = 0
    var type: ElevatorStepType = ElevatorStepType.Top
    var userInput: String = ""     
    
}

struct Elevator: Codable, Identifiable {
    var id: UInt
    var levels: [ElevatorStep]
    var complete: Bool
    var stepCount: UInt = 1
//    var tags: [String]
}
