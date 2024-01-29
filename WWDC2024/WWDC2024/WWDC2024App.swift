//
//  WWDC2024App.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 24/01/24.
//

import SwiftUI

@main
struct WWDC2024App: App {
    @StateObject var controllerInstance = Controller()
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                ModelView() //Where the 3D models will be shown
                ContentView() //Where the dialog will be shown 
            }.environmentObject(controllerInstance) //this sets the declared StateObject as observable to the intire view hierarchy
        }
    }
    
}
