import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var audio: AudioRecorder
    @State private var selectedNote: String = ""
    @State private var isOnboardingPresented: Bool = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    @State private var isBreathingModalPresented: Bool = false
    @State private var hasShownBreathingModal: Bool = UserDefaults.standard.bool(forKey: "hasSeenBreathingModal")
    @State private var isInhaling: Bool = false
    
    var body: some View {
        ZStack {
            TabView {
                Piano(audio: AudioRecorder())
                    .tabItem {
                        Label("Piano", systemImage: "pianokeys")
                    }
                Breathing(inhaling: $isInhaling)
                    .tabItem {
                        Label("Breathing", systemImage: "wind")
                    }
                    .onAppear {
                        showBreathingModalIfNeeded()
                    }
            }
            .accentColor(Color.red)
        }
        .sheet(isPresented: $isOnboardingPresented) {
            OnboardingModalView(isPresented: $isOnboardingPresented)
        }
        .sheet(isPresented: $isBreathingModalPresented) {
            BreathingModal(isPresented: $isBreathingModalPresented)
        }
    }
    private func showBreathingModalIfNeeded() {
        if !hasShownBreathingModal {
            isBreathingModalPresented = true
            hasShownBreathingModal = true
            UserDefaults.standard.set(true, forKey: "hasSeenBreathingModal")
        }
    }
}

#Preview {
    ContentView(audio: AudioRecorder())
}
