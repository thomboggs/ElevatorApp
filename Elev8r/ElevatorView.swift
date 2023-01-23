//
//  ElevatorView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI


var level1: ElevatorStep = ElevatorStep(
    id: 1,
    type: ElevatorStep.ElevatorStepType.Level,
    userInput: "Level1")
var level2: ElevatorStep = ElevatorStep(
    id: 2,
    type: ElevatorStep.ElevatorStepType.Level,
    userInput: "Level2")

var testBottom: ElevatorStep = ElevatorStep(
    id: 3,
    type: ElevatorStep.ElevatorStepType.Bottom,
    userInput: "Elevator Bottom")

var testLevels: [ElevatorStep] = Array(arrayLiteral: testStep, level1, level2, testBottom)

var testElevator: Elevator =
    Elevator(
        id: 0,
        levels: testLevels,
        complete: false
    )

struct ElevatorView: View {
    var elevator: Elevator
    
    func getStepEntry(elevator: Elevator) -> ElevatorStepEntryView?	 {
        if (!elevator.complete) {
            var step: ElevatorStep = ElevatorStep()
            step.id = elevator.stepCount + 1
            return Optional.some(ElevatorStepEntryView(fromStep: step))
        }
        return Optional.none
    }
    
    var body: some View {
        VStack {
            List(elevator.levels) { step in
                ElevatorStepView(fromStep: step)
                    .frame(maxWidth: .infinity)
            }
            .moveDisabled(true)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            getStepEntry(elevator: self.elevator)
        }
    }
}

struct ElevatorView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorView(elevator: testElevator)
        
    }
}
