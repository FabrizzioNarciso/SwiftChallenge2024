//
//  Controller.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import Foundation
import SwiftUI
import SceneKit

struct Prompt: Hashable {
    
    //This sets the properties of the main building block of the text
    var text: String
    var promptID: Int
    var modelCaller: Int = -1
    var options: [Option]
    var answer: String = "" //The answer is initialy set to a empty string, after the option is chosen, it will update as that option's "answer"
}

struct Option: Hashable {
    
    var text: String
    var answer: String
    var nextPromptID: Int
    
}

struct Model: Hashable {
    var name: String
    var modelID: Int
}




class Controller: ObservableObject {
    
    //Prompt data
    var prompts: [Prompt] {
        [
            Prompt(text: "This would be the first written thing to be seen. You should pick a response", promptID: 0, options: [
                Option(text: "Option A", answer: "This will be a witty comment",nextPromptID: 1),
                Option(text: "Option B", answer: "This will also be a witty comment",nextPromptID: 1)]),
            Prompt(text: "After the witty comment about your response, i will say something else and so on.. ", promptID: 1,modelCaller: 1, options: [
                Option(text: "Option C", answer: "Pretend what whatever is written here is funny", nextPromptID: 2),
                Option(text: "Option D", answer: "Pretend what whatever is written here is REALLY funny", nextPromptID: 2)]),
            Prompt(text: "This is to demostrate that some dialogs choices will change the background image", promptID: 2, options: [
                Option(text: "Option E", answer: "",nextPromptID: 3),
                Option(text: "Option F", answer: "",nextPromptID: 3)])
            
        ]
    }
    
    
    //3D model data
    var models: [Model] {
        [
            Model(name: "Earth.usdz", modelID: 0),
            Model(name: "Mars.usdz", modelID: 1)
        ]
    }
    
    
    //Published vars
    @Published var currentPromptID: Int = 0 //this is use to check whitch promp the game is at
    @Published var promptHistory: [Prompt] = [] //this is what the view will check to build it self
    @Published var modelID: Int = 0 //this will be used to call the 3d models to be shown 
    @Published var scene:SCNScene? //this is the 3d model called in Model view 
   
    //When the View firt appears, this init loads the first prompt in the history to start the game
    init() {
        promptHistoryUpdate(promptID: 0)
        scene = fetchModel(ID: 0)
    }
    
    
    //uppon chosing a option, this function will be called to update the promptHistory, which updates the view
    func promptHistoryUpdate(promptID: Int, answer: String? = nil) {
        
        if let prompt = prompts.first(where: { $0.promptID == promptID } ) {
            if let answer = answer {
                promptHistory[promptHistory.count - 1].answer = answer
            }
            promptHistory.append(prompt)
            currentPromptID = promptID
        }
        
    }
    
    
    //this will be called to update the 3dmodel shown in the view
    func fetchModel(ID: Int) -> SCNScene{
        
        if let model = models.first(where: { $0.modelID == ID}) {
            if let scene = SCNScene(named: model.name) {
                return scene
            }
        }
        
        
        return SCNScene(named:"Moon.usdz")!
    }
    
    
}
