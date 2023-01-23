//
//  ElevatorStepView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI

struct ElevatorStepView: View {
    var elevatorStep: ElevatorStep
    var stepType: ElevatorStep.ElevatorStepType
    var input: String = ""
    
    init(fromStep: ElevatorStep) {
        elevatorStep = fromStep
        stepType = fromStep.type
        input = fromStep.userInput
    }

    func getPrompt(stepType: ElevatorStep.ElevatorStepType) -> String {
        switch stepType {
        case ElevatorStep.ElevatorStepType.Top:
            return "Here's a prompt for you: \"What does it mean to me that...?\""
        case ElevatorStep.ElevatorStepType.Level:
            return "What does it mean to you that"
        case ElevatorStep.ElevatorStepType.BottomInit:
            return "Is it true that"
        case ElevatorStep.ElevatorStepType.BottomFinal:
            return "In a world of infinite possibilities, what could you choose to believe or do differently from thinking"
        }
    }
    var body: some View {
        VStack {
            Text(getPrompt(stepType: stepType))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
            Text(input)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.2))
        }
    }
}

struct ElevatorStepView_Previews: PreviewProvider {
    static var elevators = ModelData().elevators
    static var elevatorStepTest: ElevatorStep  = elevators[0].levels[0]
    static var previews: some View {
        ElevatorStepView(fromStep: elevatorStepTest)
    }
}
