//
//  ContentView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var  controllerInstance:Controller 
    
    var body: some View {
        HStack {
            Spacer(minLength: 640)
            
            ScrollViewReader { proxy in
                ScrollView {
                    
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
            .font(.title)
            .padding(16)
            .background(Material.ultraThin.opacity(1))
            .scrollIndicators(.hidden)
            
            Spacer(minLength: 64)
            
        }
    }
}

#Preview {
    ContentView()
}
