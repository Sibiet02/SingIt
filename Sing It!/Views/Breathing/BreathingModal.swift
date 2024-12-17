import SwiftUI

struct BreathingModal: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

           
            Text("Are you ready to practice your breathing?")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 70)

            
            BreathingModalItemView(
                icon: Image(systemName: "books.vertical"),
                iconColor: .red,
                title: "First step",
                description: "Take a couple of books from your library."
            )
            .padding(.bottom, 20)

            
            BreathingModalItemView(
                icon: Image(systemName: "bed.double"),
                iconColor: .red,
                title: "Second step",
                description: "Lie on your back and place the books on your abdomen."
            )
            .padding(.bottom, 20)
            
            BreathingModalItemView(
                icon: Image(systemName: "wind"),
                iconColor: .red,
                title: "Third step",
                description: "Breathe deeply with your abdomen, aiming to move the books up and down."
            )
            .padding(.bottom, 20)
            
            Spacer()

            
            Button(action: {
                isPresented = false
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            }) {
                Text("Start Breathing")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
    }
}

struct BreathingModalItemView: View {
    let icon: Image
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 30) {
            
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(iconColor)

           
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .bold()
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
#Preview {
    BreathingModal(isPresented: .constant(true))
}
