//
//  QuizModal.swift
//  Sing It!
//
//  Created by Silvia Esposito on 20/05/25.
//

import SwiftUI

struct QuizModal: View {
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

           
            Text("Ear Training Quiz")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 70)

            
            QuizModalItemView(
                icon: Image(systemName: "ear.badge.waveform"),
                iconColor: .red,
                title: "Goal",
                description: "Train your musical ear by identifying notes with accuracy."
            )
            .padding(.bottom, 20)

            
            QuizModalItemView(
                icon: Image(systemName: "play.circle"),
                iconColor: .red,
                title: "How it works",
                description: "Listen to a note and choose the correct one from four options. You can replay the sound as many times as needed."
            )
            .padding(.bottom, 20)
            
            QuizModalItemView(
                icon: Image(systemName: "medal"),
                iconColor: .red,
                title: "Challenge Yourself",
                description: "You’ll face 10 questions. Each correct answer boosts your score—aim for a perfect run!"
            )
            .padding(.bottom, 20)
            
            Spacer()

            
            Button(action: {
                isPresented = false
                UserDefaults.standard.set(true, forKey: "hasSeenQuizModal")
            }) {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(colorScheme == .dark ? Color.white : Color.black)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
    }
}

struct QuizModalItemView: View {
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
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
#Preview {
    QuizModal(isPresented: .constant(true))
}

