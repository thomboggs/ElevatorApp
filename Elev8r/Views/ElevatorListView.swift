//
//  ElevatorListView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/26/23.
//

import SwiftUI

struct ElevatorListView: View {
    @EnvironmentObject var thread: ActiveElevator
    private var elevators: [Elevator] = [
//        ElevatorRowView(id: thread.elevator.id, text: thread.elevator.messages[1].text).environmentObject(ActiveElevator())
//        ElevatorRowView(id: thread.elevator.id, text: thread.elevator.messages[1].text).environmentObject(ActiveElevator())
//        ElevatorRowView(id: thread.elevator.id, text: thread.elevator.messages[1].text).environmentObject(ActiveElevator())
    ]
    
    var body: some View {
        VStack {
            VStack {
                Text("Elevator")
                Text("Press the Down Button to lift your spirits")
            }.frame(maxHeight: 40, alignment: .top)
            
            ScrollViewReader { proxy in
                ScrollView {
                    Button("Start New Elevator") {
                        
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)

                    Text("Previous Elevators:")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
//                    List {
                        ElevatorRowView(id: thread.elevator.id, text: thread.elevator.messages[1].text).environmentObject(ActiveElevator())
//                    }
                }
            }
        }
    }
}

func color(fraction: Double) -> Color {
    Color(red: fraction, green: 1 - fraction, blue: 0.5)
}

struct ElevatorListView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorListView().environmentObject(ActiveElevator())
    }
}
