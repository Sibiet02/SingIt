//
//  EarTrainingQuizView.swift
//  Sing It!
//
//  Created by Silvia Esposito on 20/05/25.
//

import SwiftUI
import AVFoundation

struct EarTrainingQuizView: View {
    @StateObject private var quiz = EarTrainingQuizManager()
    @State private var feedback: String?
    @State private var selectedAnswer: String?
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 25) {
            Text("Which note is this?")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 60)

            Spacer(minLength: 15)

            if let question = quiz.currentQuestion {
                Button {
                    quiz.playCurrentNote()
                } label: {
                    Label("Play Note", systemImage: "play.circle.fill")
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(colorScheme == .dark ? .white : .black)
                        .cornerRadius(12)
                }

                VStack(spacing: 16) {
                    ForEach(question.options, id: \.self) { option in
                        Button(action: {
                            guard selectedAnswer == nil else { return }
                            selectedAnswer = option
                            let correct = quiz.check(answer: option)
                            feedback = correct ? "✅ Correct!" : "❌ Wrong! It was \(question.correctNote)"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                feedback = nil
                                selectedAnswer = nil
                                quiz.nextQuestion()
                            }
                        }) {
                            Text(option)
                                .font(.title3)
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(backgroundColor(for: option, correctAnswer: question.correctNote))
                                .cornerRadius(10)
                        }
                        .disabled(selectedAnswer != nil)
                    }
                }

                if let feedback = feedback {
                    Text(feedback)
                        .font(.headline)
                        .foregroundColor(feedback.contains("Correct") ? .green : .red)
                        .padding(.top, 10)
                }

                Text("Score: \(quiz.score)")
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .white : .secondary)
                    .padding(.top, 10)

            } else {
                Text("Quiz completed")
                    .font(.title2)

                Text("Final Score: \(quiz.score)")
                    .font(.title3)

                Text(finalMessage)
                    .font(.body)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button("Try Again") {
                    quiz.restart()
                }
                .font(.title3)
                .padding()
                .background(colorScheme == .dark ? .white : .black)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .cornerRadius(10)

                Spacer()
            }

            Spacer(minLength: 40)
        }
        .padding()
        .animation(.easeInOut, value: quiz.currentQuestion)
    }

    // MARK: - Colore dinamico del bottone
    func backgroundColor(for option: String, correctAnswer: String) -> Color {
        if let selected = selectedAnswer {
            if option == correctAnswer {
                return .green
            } else if option == selected {
                return .red
            }
        }
        return colorScheme == .dark ? Color.white.opacity(0.5) : Color.gray.opacity(0.2)
    }

    // MARK: - Messaggio finale motivazionale
    var finalMessage: String {
        switch quiz.score {
        case 0...3:
            return "Practice a little bit more, you can do it!"
        case 4...6:
            return "You are on the right path, you got this!"
        case 7...9:
            return "You're almost there!"
        case 10:
            return "Perfect score, congrats!"
        default:
            return ""
        }
    }
}


#Preview {
    EarTrainingQuizView()
}
