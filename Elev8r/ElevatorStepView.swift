//
//  ElevatorStepView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI

var testStep : ElevatorStep = ElevatorStep(
    id: 0,
    type: ElevatorStep.ElevatorStepType.Top,
    userInput: "My App is no good."
)


struct ElevatorStepView: View {
    var elevatorStep: ElevatorStep
    var stepType: ElevatorStep.ElevatorStepType
    var input: String = ""
    
    init(fromStep: ElevatorStep) {
        elevatorStep = fromStep
        stepType = fromStep.type
        input = fromStep.userInput
    }

    func getTitle(stepType: ElevatorStep.ElevatorStepType) -> String {
        switch stepType {
        case ElevatorStep.ElevatorStepType.Top:
            return "Elevator Top"
        case ElevatorStep.ElevatorStepType.Level:
            return "Elevator Level"
        case ElevatorStep.ElevatorStepType.Bottom:
            return "Elevator Bottom"
        }
    }
    var body: some View {
        VStack {
            Text(getTitle(stepType: stepType))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
            Text(input)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.2))
        }
    }
}

struct ElevatorStepView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorStepView(fromStep: testStep)
    }
}
