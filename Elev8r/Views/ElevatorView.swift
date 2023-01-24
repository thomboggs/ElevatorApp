//
//  ElevatorView.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import SwiftUI


struct ElevatorView: View {
    @EnvironmentObject var thread: ActiveElevator
    @State var input: String = ""
    
    func getAppMessage(inputString: String = "") -> String {
        let basicPrefix: String = "What does it mean to you that"
        
        switch thread.elevator.state {
        case Elevator.ElevatorStatus.Top:
            return "\"" + basicPrefix + "...\""
        case Elevator.ElevatorStatus.Level:
            return basicPrefix + " \"" + inputString + "\" ?"
        case Elevator.ElevatorStatus.BottomInit:
            return "Is it true that \"" + inputString + "\" ?"
        case Elevator.ElevatorStatus.BottomFinal:
            return "In a world of infinite possibilites... \"" + thread.elevator.messages[1].text + "\" ?"
        default:
            return ""
        }
    }
    
    func displayMessage(message: ElevatorMessage) -> some View {
        if (message.source == ElevatorMessage.MessageSource.App) {
            return Text(message.text)
                .padding([.leading, .trailing], 20.0)
                .background(Color.green.opacity(0.2))
                .clipShape(Capsule())
                .padding(.trailing, 25.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 5.0)
                
                
        }
        
        return Text(message.text)
            .padding([.leading, .trailing], 20.0)
            .background(Color.blue.opacity(0.2))
            .clipShape(Capsule())
            .padding(.leading, 25.0)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .multilineTextAlignment(.trailing)
            .padding(.bottom, 5.0)
            
    }
    
    func onSendPressed() {
        thread.elevator.stepCount += 1
        // create new ElevatorMessage with:
        // - text = $input
        // - id = stepcount+1 (Don't forget to increment step count)
        // - Push to back of the messages array
        var newMessage = ElevatorMessage()
        newMessage.id = thread.elevator.stepCount
        newMessage.text = $input.wrappedValue
        newMessage.source = ElevatorMessage.MessageSource.User
        
        thread.elevator.messages.append(newMessage)
        
        // Create new elvator message from app
        // - Current state of the app determines the prefix.
        // - $input is what is quoted
        // - push to back of the message array
        thread.elevator.stepCount += 1
        var appResponse = ElevatorMessage()
        appResponse.id = thread.elevator.stepCount
        appResponse.source = ElevatorMessage.MessageSource.App
        appResponse.text = getAppMessage(inputString: $input.wrappedValue)
        
        thread.elevator.messages.append(appResponse)
        
        // Set $input back to default
        // redraw? Is this necessary?
        $input.wrappedValue = ""
    }
    
    func onBottomPressed() {
        
    }
    
    var body: some View {
        VStack {
            Button("I'm at the Bottom", action: onBottomPressed)
                .padding()
                .background(Color.blue.opacity(0.2))
                .clipShape(Capsule())
        
            ScrollView {
                ForEach(thread.elevator.messages) {message in
                    displayMessage(message: message)
                        
                        
                }
            }
            
            Spacer()
            
            TextField("...", text: $input)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.1))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                

            Button("Send", action: onSendPressed)
                .padding()
                .background(Color.blue.opacity(0.1))
                .clipShape(Capsule())
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ElevatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ElevatorView().environmentObject(ActiveElevator())
        }
        
    }
}
