//
//  Controller.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import Foundation
import SwiftUI

struct Prompt: Hashable {
    
    //This sets the properties of the main building block of the text
    var text: String
    var promptID: Int
    var options: [Option]
    var answer: String = ""
    
}

struct Option: Hashable {
    
    var text: String
    var answer: String
    var nextPromptID: Int
    
}



class Controller: ObservableObject {
    
    var prompts: [Prompt] {
        [
            Prompt(text: "This would be the first written thing to be seen. You should pick a response", promptID: 0, options: [
                Option(text: "Option A", answer: "This will be a witty comment",nextPromptID: 1),
                Option(text: "Option B", answer: "This will also be a witty comment",nextPromptID: 1)]),
            Prompt(text: "After the witty comment about your response, i will say something else and so on.. ", promptID: 1, options: [
                Option(text: "Option C", answer: "Pretend what whatever is written here is funny", nextPromptID: 2),
                Option(text: "Option D", answer: "Pretend what whatever is written here is REALLY funny", nextPromptID: 2)]),
            Prompt(text: "This is to demostrate that some dialogs choices will change the background image", promptID: 2, options: [
                Option(text: "Option E", answer: "",nextPromptID: 3),
                Option(text: "Option F", answer: "",nextPromptID: 3)])
            
        ]
    }
    
    @Published var currentPromptID: Int = 0
    @Published var promptHistory: [Prompt] = []
   
    
    init() {
        promptHistoryUpdate(promptID: 0)
    }
    
    func promptHistoryUpdate(promptID: Int, answer: String? = nil) {
        if let prompt = prompts.first(where: { $0.promptID == promptID } ) {
            
            if let answer = answer {
                promptHistory[promptHistory.count - 1].answer = answer
            }
            
            promptHistory.append(prompt)
            currentPromptID = promptID

        }
    }
    
    func fetchPrompt() -> Prompt {
        guard let prompt = prompts.first(where: { $0.promptID == currentPromptID } ) else { return Prompt(text: "Error while fetching prompt", promptID: -1, options: []) }
        return prompt
    }
    
    func fetchOptions(index: Int) -> String {
      
        if let prompt = prompts.first(where: { $0.promptID == currentPromptID } ) {
            return prompt.options[index].text
        } else {
            return String("Option not found")
        }
    }
    
    
}
