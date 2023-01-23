//
//  ElevatorView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI

//var testTop: ElevatorStep = ElevatorStep(
//    id: 0,
//    type: ElevatorStep.ElevatorStepType.Top,
//    userInput: "Elevator Bottom")
//
//var level1: ElevatorStep = ElevatorStep(
//    id: 1,
//    type: ElevatorStep.ElevatorStepType.Level,
//    userInput: "Level1")
//var level2: ElevatorStep = ElevatorStep(
//    id: 2,
//    type: ElevatorStep.ElevatorStepType.Level,
//    userInput: "Level2")
//
//var testBottom: ElevatorStep = ElevatorStep(
//    id: 3,
//    type: ElevatorStep.ElevatorStepType.Bottom,
//    userInput: "Elevator Bottom")
//
//var testLevels: [ElevatorStep] = Array(arrayLiteral: testStep, level1, level2, testBottom)
//
//var testElevator: Elevator =
//    Elevator(
//        id: 0,
//        levels: testLevels,
//        complete: false
//    )

//struct Button<Label> where Label : View

struct ElevatorView: View {
    @EnvironmentObject var modelData: ModelData
    
    func getStepEntry(elevator: Elevator) -> ElevatorStepEntryView?	 {
        if (!elevator.complete) {
            var step: ElevatorStep = ElevatorStep()
            step.id = elevator.stepCount + 1
            return Optional.some(ElevatorStepEntryView(fromStep: step))
        }
        return Optional.none
    }
    
    func onSendPressed() {
        
    }
    
    func onBottomPressed() {
        
    }
    
    var body: some View {
        var elevators: [Elevator] = modelData.elevators
        
        VStack {
            Button("I'm at the Bottom", action: onBottomPressed)
        
            List(elevators[0].levels) { step in
                ElevatorStepView(fromStep: step)
                    .frame(maxWidth: .infinity)
            }
            .moveDisabled(true)
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            getStepEntry(elevator: elevators[0])

            Button("Send", action: onSendPressed)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
        }
    }
}

struct ElevatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ElevatorView().environmentObject(ModelData())
        }
        
    }
}
