//
//  ModelView.swift
//  NavigationExercise
//
//  Created by Fabrizio Narciso on 19/01/24.
//

import SwiftUI
import SceneKit
import UIKit

struct ModelView: View {
    
    @EnvironmentObject var controllerInstance:Controller
    
    var body: some View {
        
        SceneView(scene: controllerInstance.fetchModel(ID: controllerInstance.modelID), options: [.autoenablesDefaultLighting, .allowsCameraControl])
            .ignoresSafeArea()
        
    }
   
}


      
        


