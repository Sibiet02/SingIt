import SwiftUI

struct NoteFlashcardView: View {
    let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C5"]
    @State private var currentNote = "C"
    
    var body: some View {
        VStack {
           
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 300, height: 200)
                    .shadow(color: .gray.opacity(0.5), radius: 10)
                
           
                Text(currentNote)
                    .font(.largeTitle)
                    .foregroundColor(.red)
            }
            
            
            Button(action: {
   
                currentNote = notes.randomElement()!
            }, label: {
                Image(systemName: "shuffle.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .padding()
            })
            .accessibilityLabel("shuffle")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    NoteFlashcardView()
}
