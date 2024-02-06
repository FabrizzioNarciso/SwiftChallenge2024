import SwiftUI

@main
@available(iOS 17.0, *)

struct MyApp: App {
    var body: some Scene {
        @ObservedObject var controllerInstance = Controller()
        
        WindowGroup {
            ZStack {
                ModelView() //Where the 3D models will be shown
                ContentView() //Where the dialog will be shown
            }.environmentObject(controllerInstance) //this sets the declared StateObject as observable to the intire view hierarchy
            .preferredColorScheme(.dark)
        }
        
    }
}
