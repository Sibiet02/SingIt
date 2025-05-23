import SwiftUI

struct NoteFlashcardView: View {
    let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C5"]
    @State private var currentNote = "C"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
           
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? .gray.opacity(0.9) : .white)
                    .frame(width: 300, height: 200)
                    .shadow(color: .gray.opacity(0.5), radius: 10)
                
           
                Text(currentNote)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red.opacity(0.9))
            }
            
            
            Button(action: {
   
                currentNote = notes.randomElement()!
            }, label: {
                Image(systemName: "shuffle.circle")
                    .resizable()
                    .bold()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red.opacity(0.9))
                    .padding()
            })
            .accessibilityLabel("shuffle")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    NoteFlashcardView()
}
