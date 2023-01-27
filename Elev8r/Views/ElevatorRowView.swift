//
//  ElevatorRowView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/26/23.
//

import SwiftUI

struct ElevatorRowView: View, Identifiable {
    @EnvironmentObject var thread: ActiveElevator
    let id: UUID
    let text: String
    
    
    var body: some View {
        Text(text)
            .padding()
            .truncationMode(.tail)
            .border(Color.black, width: 2)
    }
}

struct ElevatorRowView_Previews: PreviewProvider {
    static var previews: some View {
        ElevatorRowView(id: UUID(), text: "Start Of elevator 1").environmentObject(ActiveElevator())
    }
}
