//
//  StartQuizView.swift
//  Sing It!
//
//  Created by Silvia Esposito on 20/05/25.
//

import SwiftUI

struct StartQuizView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var navigateToQuiz = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()

                Text("Are you ready to start the quiz?")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()

                NavigationLink(destination: EarTrainingQuizView(), isActive: $navigateToQuiz) {
                    EmptyView()
                }

                Button("Start Quiz") {
                    navigateToQuiz = true
                }
                .font(.title2)
                .padding()
                .background(colorScheme == .dark ? .white : .black)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .cornerRadius(12)

                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    StartQuizView()
}
