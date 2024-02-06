//
//  ModelView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 06/02/24.
//

import Foundation
import SwiftUI
import SceneKit
import UIKit

struct ModelView: View {
    
    @EnvironmentObject var controllerInstance:Controller
    
    var body: some View {
        
        SceneView(scene: controllerInstance.scene, options: [.autoenablesDefaultLighting, .allowsCameraControl])
            .ignoresSafeArea()
        
    }
   
}
