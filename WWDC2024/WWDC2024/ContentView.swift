//
//  ContentView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var controllerInstance = Controller()

    var body: some View {
       VStack
        {
            ForEach(controllerInstance.promptHistory, id:\.self) { prompt in
                Text(prompt.text)
                
                ForEach(prompt.options, id:\.self) { option in
                    Button(action: {
                        
                        controllerInstance.promptHistoryUpdate(promptID: option.nextPromptID, answer: option.answer)
               

                    }
                           , label: {
                        Text(option.text)
                    }).disabled(prompt.promptID != controllerInstance.currentPromptID)
                }
                Text(prompt.answer)
              
            }
        }
       
    }
}

#Preview {
    ContentView()
}
