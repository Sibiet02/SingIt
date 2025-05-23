import SwiftUI
import AVFoundation

struct PianoKeyView: View {
    let note: String
    let isBlack: Bool
    @Binding var selectedNote: String 
    @State private var isPressed: Bool = false
    private var player: AVAudioPlayer?

    init(note: String, isBlack: Bool, selectedNote: Binding<String>) {
        self.note = note
        self.isBlack = isBlack
        self._selectedNote = selectedNote
        self.player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: note, withExtension: "mp3")!)
    }

    var body: some View {
        Button(action: {
            selectedNote = note
            playSound()
        }) {
            Rectangle()
                .fill(isPressed ? (isBlack ? Color.gray : Color.red) : (isBlack ? Color.black : Color.white))
                .frame(width: isBlack ? 30 : 50, height: isBlack ? 120 : 200)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
        .accessibilityLabel(note)
        .buttonStyle(PlainButtonStyle())
        .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }

    private func playSound() {
        player?.stop()
        player?.currentTime = 0
        player?.play()
    }
}
