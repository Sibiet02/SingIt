import SwiftUI

struct Keyboard: View {
    @Binding var selectedNote: String

    private let whiteNotes = ["C", "D", "E", "F", "G", "A", "B", "C5"]
    private let blackNotes = ["C#", "D#", "F#", "G#", "A#"]

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                ForEach(whiteNotes, id: \.self) { note in
                    PianoKeyView(note: note, isBlack: false, selectedNote: $selectedNote)
                }
            }

            HStack(spacing: 0) {
                Group {
                    PianoKeyView(note: "C#", isBlack: true, selectedNote: $selectedNote)
                        .offset(x: 35)
                    
                    PianoKeyView(note: "D#", isBlack: true, selectedNote: $selectedNote)
                        .offset(x: 55)
                    
                    Spacer().frame(width: 50)
                    
                    PianoKeyView(note: "F#", isBlack: true, selectedNote: $selectedNote)
                        .offset(x: 75)
                    
                    PianoKeyView(note: "G#", isBlack: true, selectedNote: $selectedNote)
                        .offset(x: 95)
                    
                    PianoKeyView(note: "A#", isBlack: true, selectedNote: $selectedNote)
                        .offset(x: 115)
                }
            }
        }
    }
}

