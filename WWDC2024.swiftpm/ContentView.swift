//
//  ContentView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var controllerInstance:Controller
    
    init() { //font
        let cfURL = Bundle.main.url(forResource: "NewYork", withExtension: "ttf")!
        CTFontManagerRegisterFontsForURL(cfURL as CFURL, CTFontManagerScope.process, nil)
    }
    
    var body: some View {
        
        GeometryReader { geometry in //used to set the size of the Spacers, defining where the View will be in relation the the screen
            HStack {
                
                Spacer()
                    .frame(width: geometry.size.width * 0.6)
                
                VStack {
                    Spacer()
                    
                    ScrollView {
                        
                        HStack {
                            Text("NARRATOR:")
                                .foregroundStyle(Color.gray)
                                .padding(.top, 32)
                            Spacer()
                        }
                        
                        
                        ForEach(controllerInstance.promptHistory, id:\.self) { prompt in
                            
                            HStack {
                                Text(prompt.text)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 8)
                                Spacer()
                            }
                            
                            HStack {
                                Text("You:")
                                    .foregroundStyle(Color.gray)
                                Spacer()
                            }
                            
                            HStack {
                                VStack {
                                    
                                    ForEach(prompt.options, id:\.self) { option in
                                        
                                        Button(action: {
                                            //When the button is selected, the linked answer will be uptaded, and the next prompt will be loaded in the promptHistory, whitch is used to build the View
                                            withAnimation(.easeIn(duration: 1).delay(0.2)) {
                                                controllerInstance.promptHistoryUpdate(promptID: option.nextPromptID, answer: option.answer)
                                                //If a set option should trigger a change in the 3D model, this will be called
                                                if prompt.modelCaller != -1 {
                                                    controllerInstance.modelID = prompt.modelCaller
                                                    
                                                    controllerInstance.player = controllerInstance.fetchModel(ID: controllerInstance.modelID)
                                                    
                                                }
                                                
                                            }
                                        }
                                               , label: {
                                            HStack {
                                                Text(option.text)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.bottom,8)
                                                Spacer()
                                            }
                                            
                                            
                                            
                                        }).disabled(prompt.promptID != controllerInstance.currentPromptID) //if that choice has being made, the buttons should disable
                                        
                                    }
                                }
                                Spacer()
                            }
                            
                            HStack {
                                Text(prompt.answer) //initialy empty, this will be updated uppon chosing a option
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                Spacer()
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    .font(.custom("New York", size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 16))
                    .padding(16)
                    .background(
                        Material.ultraThin.blendMode(.plusDarker)
                    )
                    
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                
                
                
                
                Spacer()
                   .frame(width: geometry.size.width * 0.03)
                
            }
        }
    }
}

