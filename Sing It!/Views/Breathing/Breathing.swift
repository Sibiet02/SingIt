import SwiftUI
import AVFoundation

struct Breathing: View {
    @Binding var inhaling: Bool
    @State private var size = minSize
    @State private var ghostSize = ghostMaxSize
    @State private var ghostBlur: CGFloat = 0
    @State private var ghostOpacity: Double = 0
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            Text(inhaling ? "Breath In" : "Breath Out")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .animation(.easeInOut, value: inhaling)
                .padding(.top, 70)
       
            ZStack {
                ZStack {
                    Petals(size: ghostSize, inhaling: inhaling)
                        .blur(radius: ghostBlur)
                        .opacity(ghostOpacity)
                    
                    Petals(size: size, inhaling: inhaling, isMask: true)
                    
                    Petals(size: size, inhaling: inhaling)
                    Petals(size: size, inhaling: inhaling)
                        .rotationEffect(.degrees(smallAngle))
                        .opacity(inhaling ? 0.8 : 0.6)
                }
                .rotationEffect(.degrees(inhaling ? bigAngle : -smallAngle))
                .drawingGroup()
            }
            .onAppear {
                performAnimations()
            }
            .onChange(of: inhaling) { _ in
                speakText()
            }
        }
    }
    
    private func performAnimations() {
        withAnimation(.easeInOut(duration: inhaleTime)) {
            inhaling = true
            size = maxSize
        }
        
        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTime, repeats: false) { _ in
            startExhalingAnimation()
        }
    }
    
    private func startExhalingAnimation() {
        ghostSize = ghostMaxSize
        ghostBlur = 0
        ghostOpacity = 0.8
        
        Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.2, repeats: false) { _ in
            withAnimation(.easeOut(duration: exhaleTime * 0.6)) {
                ghostBlur = 30
                ghostOpacity = 0
            }
        }
        withAnimation(.easeInOut(duration: exhaleTime)) {
            inhaling = false
            size = minSize
            ghostSize = ghostMinSize
        }
        
        Timer.scheduledTimer(withTimeInterval: exhaleTime + pauseTime, repeats: false) { _ in
            performAnimations()
        }
    }
    
    private func speakText() {
        let utterance = AVSpeechUtterance(string: inhaling ? "Breath In" : "Breath Out")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}

#Preview {
    Breathing(inhaling: .constant(true))
}
