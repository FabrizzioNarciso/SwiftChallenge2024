//
//  ModelView.swift
//  WWDC2024
//
//  Created by Fabrizio Narciso on 06/02/24.
//

import Foundation
import SwiftUI
import AVKit
import UIKit

struct ModelView: View {
    
    @EnvironmentObject var controllerInstance:Controller
    
    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(player: controllerInstance.player)
                .disabled(true)
                //.frame(width: geometry.size.width, height: geometry.size.height)
                .ignoresSafeArea()
                .onAppear {
                    controllerInstance.player?.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in self.controllerInstance.player?.seek(to: .zero)
                        self.controllerInstance.player?.play()
                    }
                }
                .onChange(of: controllerInstance.player) { _ in
                    controllerInstance.player?.play()
                    
                }
            
        }
       
    }
   
}
