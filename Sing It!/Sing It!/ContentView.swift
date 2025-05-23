import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
    @ObservedObject var audio: AudioRecorder
    @State private var selectedNote: String = ""
    @State private var isOnboardingPresented: Bool = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    @State private var isBreathingModalPresented: Bool = false
    @State private var hasShownBreathingModal: Bool = UserDefaults.standard.bool(forKey: "hasSeenBreathingModal")
    @State private var isQuizModalPresented: Bool = false
    @State private var hasShownQuizModal: Bool = UserDefaults.standard.bool(forKey: "hasSeenQuizModal")
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
                StartQuizView()
                    .tabItem {
                        Label("Quiz", systemImage: "pencil.and.list.clipboard")
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
        .sheet(isPresented: $isQuizModalPresented) {
            QuizModal(isPresented: $isQuizModalPresented)
        }
    }
    private func showBreathingModalIfNeeded() {
        if !hasShownBreathingModal {
            isBreathingModalPresented = true
            hasShownBreathingModal = true
            UserDefaults.standard.set(true, forKey: "hasSeenBreathingModal")
        }
    }
    private func showQuizModalIfNeeded() {
        if !hasShownQuizModal {
            isQuizModalPresented = true
            hasShownQuizModal = true
            UserDefaults.standard.set(true, forKey: "hasSeenQuizModal")
        }
    }
}

#Preview {
    ContentView(audio: AudioRecorder())
}
