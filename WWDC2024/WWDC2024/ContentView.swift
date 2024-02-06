//
//  ContentView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var controllerInstance:Controller
    
    var body: some View {
        
        GeometryReader { geometry in //used to set the size of the Spacers, defining where the View will be in relation the the screen
            HStack {
                
                Spacer()
                    .frame(width: geometry.size.width * 0.55)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(controllerInstance.promptHistory, id:\.self) { prompt in
                            
                            Text(prompt.text)
                            
                            ForEach(prompt.options, id:\.self) { option in
                                
                                Button(action: {
                                    
                                    //When the button is selected, the linked answer will be uptaded, and the next prompt will be loaded in the promptHistory, whitch is used to build the View
                                    controllerInstance.promptHistoryUpdate(promptID: option.nextPromptID, answer: option.answer)
                                    
                                    
                                    //If a set option should trigger a change in the 3D model, this will be called
                                    if prompt.modelCaller != -1 {
                                        controllerInstance.modelID = prompt.modelCaller
                                        controllerInstance.scene = controllerInstance.fetchModel(ID: controllerInstance.modelID)
                                    }
                                }
                                       , label: {
                                    Text(option.text)
                                    
                                }).disabled(prompt.promptID != controllerInstance.currentPromptID) //if that choice has being made, the buttons should disable
                            }
                            
                            Text(prompt.answer) //initialy empty, this will be updated uppon chosing a option
                            
                            .id(prompt) //this is used for the automatic scrolling
                            
                        }
                        
                        
                        
                        //The "proxy" defined in the ScrollViewReader will scroll to bottom every time the promptHistory gets updated with a new Prompt
                        .onChange(of: controllerInstance.promptHistory.count) {
                            proxy.scrollTo(controllerInstance.promptHistory.last)
                            
                        }
                    }
                    
                }
                .font(.title)
                .padding(16)
                .background(Material.ultraThin.opacity(1))
                .scrollIndicators(.hidden)
                
                Spacer()
                    .frame(width: geometry.size.width * 0.05)
                
            }
        }
    }
}

#Preview {
    ContentView()
}
