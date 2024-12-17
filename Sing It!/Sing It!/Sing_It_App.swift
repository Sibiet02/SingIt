//
//  Sing_It_App.swift
//  Sing It!
//
//  Created by Silvia Esposito on 17/12/24.
//

import SwiftUI

@main
struct Sing_It_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audio: AudioRecorder())
        }
    }
}
