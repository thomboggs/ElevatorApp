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
    @State var update: Bool = false
//    @Namespace var bottomID
    
    func getAppMessage(inputString: String = "") -> String {
        let basicPrefix: String = "What does it mean to you if"
        
        switch thread.elevator.state {
        case Elevator.ElevatorStatus.Level:
            return basicPrefix + " \"" + inputString + "\" ?"
        case Elevator.ElevatorStatus.BottomInit:
            thread.elevator.state = Elevator.ElevatorStatus.BottomFinal
            return "Is it true that \"" + inputString + "\" ?"
        case Elevator.ElevatorStatus.BottomFinal:
            thread.elevator.state = Elevator.ElevatorStatus.Complete
            return "In a world of infinite possibilites... \"" + thread.elevator.messages[1].text + "\" ?"
        case Elevator.ElevatorStatus.Complete:
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
        // create new ElevatorMessage with:
        // - text = $input
        // - id = stepcount+1 (Don't forget to increment step count)
        // - Push to back of the messages array
        var newMessage = ElevatorMessage()
        newMessage.text = $input.wrappedValue
        newMessage.source = ElevatorMessage.MessageSource.User
        thread.elevator.messages.append(newMessage)
        
        // Create new elvator message from app
        // - Current state of the app determines the prefix.
        // - $input is what is quoted
        // - push to back of the message array
        var appResponse = ElevatorMessage()
        appResponse.source = ElevatorMessage.MessageSource.App
        appResponse.text = getAppMessage(inputString: $input.wrappedValue)
        thread.elevator.messages.append(appResponse)
        
        // Set $input back to default
        $input.wrappedValue = ""
        
        update.toggle()
    }
    
    func onBottomPressed() {
        // State Changes to first bottom
        thread.elevator.state = Elevator.ElevatorStatus.BottomInit
        // Display message using most recent
        
        if ($input.wrappedValue != "") {
            var newMessage = ElevatorMessage()
            newMessage.text = $input.wrappedValue
            newMessage.source = ElevatorMessage.MessageSource.User
            thread.elevator.messages.append(newMessage)
        }
        
        var appResponse = ElevatorMessage()
        appResponse.source = ElevatorMessage.MessageSource.App
        appResponse.text = getAppMessage(inputString: $input.wrappedValue)
        thread.elevator.messages.append(appResponse)
        
        $input.wrappedValue = ""
        
        update.toggle()
    }
    
    func onBackButtonPressed() {
        
    }
    
    func showBottomButton() -> Bool {
        return thread.elevator.state == Elevator.ElevatorStatus.Level
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Back", action: onBackButtonPressed)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20.0)
                
                if (showBottomButton()) {
                    Button("I'm at the Bottom", action: onBottomPressed)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .clipShape(Capsule())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 20.0)
                }
            }
            
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    VStack {
                        ForEach(thread.elevator.messages, id: \.self) {message in
                            displayMessage(message: message)
                        }
                    }.id("ChatScrollView")
                } .onChange(of: update) { _ in
                    withAnimation {
                        scrollView.scrollTo("ChatScrollView", anchor: .bottom)
                    }
                }
//                    .onAppear {
//                        scrollView.scrollTo(thread.elevator.messages[thread.elevator.messages.endIndex - 1])
//                    }
//                }
//                .onChange(of: update) { _ in
//                    scrollView.scrollTo(thread.elevator.messages[thread.elevator.messages.endIndex - 1])
//                }
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
