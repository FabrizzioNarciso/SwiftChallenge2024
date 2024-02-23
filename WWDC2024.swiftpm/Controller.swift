//
//  Controller.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 06/02/24.
//

import Foundation
import SwiftUI
import AVKit

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
            Prompt(text: "In the beginning there was nothing. \nWell, not really. \nThere was no “beginning”. No “middle” or “end”. Not even a “there”, actually. Without any time or place. \nJust sweet sweet nothing.", promptID: 0, modelCaller: 1, options: [
                Option(text: "1. Mmmh, sounds boring", answer: "Well, maybe. But think about it, The silence, the pure bliss. \nBUT  as we know, nothing good ever lasts. At some point, things changed from nothing to something.",nextPromptID: 1),
                Option(text: "2. Wait, really? Nothing?", answer: "Not. A. Thing. \nNot even the concept of ”thing”. \nIt was just the ____. \n(Actually no one knows for sure. But it is more trippy to say that it was the ____, so bear with me.)",nextPromptID: 1)]),
            Prompt(text: "So after the nothing, there was STUFF. \nHOT stuff. Just floating around, being too warm to do anything else.", promptID: 1, options: [
                Option(text: "1. When was this?", answer: "Right at the very beginning of “when“. Like i said, before, there was no when, but when “when“ started, so did Stuff.", nextPromptID: 2),
                Option(text: "2. “Hot stuff“ doesn't sound very, you know, scientific.", answer: "Well if you really must know, the fancy word for stuff is “matter“, and it being hot was caused by what is known as “energy“. But get out of here with these technicalities.", nextPromptID: 2)]),
            Prompt(text: "This first state of ”everywhere-stuff-was-really-hot” didn't change for a WHILE. Things had to cool down a bit.", promptID: 2, modelCaller: 2, options: [
                Option(text: "1. So it was still kinda boring. Great.", answer: "Be patient. Remember that the end of this story is that you now have to worry about things like what to have for dinner and whatever a ”Large Language Model” is.",nextPromptID: 3),
                Option(text: "2. How much time?", answer: "400 000 years give or take. \nOr 3 jimbos. \nOr 5.7 flerberts. \nOutside the average lifespan of us fleshy things, time starts to have little meaning, so go crazy!",nextPromptID: 3)]),
            Prompt(text: "When stuff cooled down enough, it started to group together into these tiny things Nerds call ”Atoms”, but i think we should give them our own name.", promptID: 3, options: [
                Option(text:"1. Ahhh, ”Carlos”?", answer: "Perfect.", nextPromptID: 4),
                Option(text:"2. What about: The Basic Build Block, or BBB, for short?", answer: "Nah, that's bad. Let's go with Carlos.", nextPromptID: 4)]),
            Prompt(text: "It turns out that stuff has a property that makes it attract other stuff. So, over time, a bunch of Carlos’ gets closer and closer together, until there is too much of it, TOO close.\n \nAnd, through the magic of FUSION, a big hot ball, called a Star, is born. \n \nFUSION combines the Stuff that makes up the simpler Atoms (or Carlos) in a Star into other, more complex types of Atoms.", promptID: 4, modelCaller: 2, options: [
                Option(text:"1. How many different types of Atoms?", answer: "A lot. Only a few types don't naturally occur through this process. Those are made in a ”Lab”, which is a room with really bright lights and really EXPENSIVE toys.", nextPromptID: 5),
                Option(text:"2. Why did you give other things silly made up names, but chose to keep the real name for Fusion?", answer: "First, all words are made up. \nSecond, FUSION is already a pretty cool name. Not as cool as Carcinization, mind you, but still pretty cool. (No, I will not elaborate on what that is).", nextPromptID: 5)])
                
            
        ]
    }
    
    
    //3D model data
    var models: [Model] {
        [
            Model(name: "Scene1", modelID: 0),
            Model(name: "Scene2", modelID: 1),
            Model(name: "Scene3", modelID: 2)
        ]
    }
    
    
    //Published vars
    @Published var currentPromptID: Int = 0 //this is use to check whitch promp the game is at
    @Published var promptHistory: [Prompt] = [] //this is what the view will check to build it self
    @Published var modelID: Int = 0 //this will be used to call the 3d models to be shown
    @Published var player: AVPlayer?//this is the 3d model called in Model view
   
    //When the View firt appears, this init loads the first prompt in the history to start the game
    init() {
        promptHistoryUpdate(promptID: 0)
        player = fetchModel(ID: 0)
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
    func fetchModel(ID: Int) -> AVPlayer{
        
        if let model = models.first(where: { $0.modelID == ID}) {
            if let scene = Bundle.main.url(forResource: model.name, withExtension: "mp4") {
                let player = AVPlayer(url: scene)
                return player
                
            }
        }
        
        return AVPlayer(url: Bundle.main.url(forResource: "Scene1", withExtension: "mp4")!)
        
        
    }
    
    
}
