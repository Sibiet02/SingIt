import SwiftUI

struct OnboardingModalView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Welcome to Sing It!")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 70)
            
            OnboardingItemView(
                icon: Image(systemName: "music.note"),
                iconColor: .red,
                title: "Find your note",
                description: "Improve your pitch by practicing with the piano and checking the accuracy of your voice."
            )
            .padding(.bottom, 20)

     
            OnboardingItemView(
                icon: Image(systemName: "music.microphone"),
                iconColor: .red,
                title: "Train your intonation",
                description: "Compare notes and sharpen your vocal precision while developing musical ear and control."
            )
            .padding(.bottom, 20)
           
            OnboardingItemView(
                icon: Image(systemName: "wind"),
                iconColor: .red,
                title: "Breathe better, sing better",
                description: "Follow diaphragmatic breathing exercises to achieve stable breath control and a stronger voice."
            )
            .padding(.bottom, 20)
            
            Spacer()

            Button(action: {
                isPresented = false
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            }) {
                Text("Next")
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

struct OnboardingItemView: View {
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
    OnboardingModalView(isPresented: .constant(true))
}
