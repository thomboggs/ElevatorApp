//
//  ContentView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ElevatorView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
