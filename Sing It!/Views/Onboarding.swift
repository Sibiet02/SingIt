import SwiftUI

struct OnboardingModalView: View {
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()

            Text("Welcome to Sing It!")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            
            OnboardingItemView(
                icon: Image(systemName: "music.note"),
                iconColor: .red,
                title: "Find your note",
                description: "Improve your pitch by practicing with the piano."
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
            
            OnboardingItemView(
                icon: Image(systemName: "bell.and.waves.left.and.right.fill"),
                iconColor: .red,
                title: "Sound on",
                description: "Make sure your iPhone isn’t on silent mode to hear the sound properly."
            )
            .padding(.bottom, 20)
            
            Spacer()

            Button(action: {
                isPresented = false
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(colorScheme == .dark ? .white : .black)
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
    @Environment(\.colorScheme) var colorScheme
    
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
                    .foregroundColor(colorScheme == .dark ? .white : .secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
#Preview {
    OnboardingModalView(isPresented: .constant(true))
}
