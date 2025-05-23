import Foundation
import AVFoundation


class EarTrainingQuizManager: ObservableObject {
    @Published var currentQuestion: EarTrainingQuestion?
    @Published var score = 0
    @Published var questionIndex = 0

    private var questions: [EarTrainingQuestion] = []
    private var audioPlayer: AVAudioPlayer?

    private let availableNotes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C5"]

    init() {
        generateQuestions()
        nextQuestion()
    }

    private func generateQuestions() {
        questions = []

        for _ in 0..<10 {
            guard let correct = availableNotes.randomElement() else { continue }
            var options = Set([correct])
            while options.count < 4 {
                if let randomNote = availableNotes.randomElement() {
                    options.insert(randomNote)
                }
            }
            questions.append(EarTrainingQuestion(correctNote: correct, options: Array(options).shuffled()))
        }

        questions.shuffle()
    }

    func playCurrentNote() {
        guard let note = currentQuestion?.correctNote else { return }
        playSound(named: note)
    }

    private func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("❌ Audio file \(name).mp3 not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("❌ Error playing audio: \(error.localizedDescription)")
        }
    }

    func check(answer: String) -> Bool {
        let isCorrect = answer == currentQuestion?.correctNote
        if isCorrect { score += 1 }
        return isCorrect
    }

    func nextQuestion() {
        guard questionIndex < questions.count else {
            currentQuestion = nil
            return
        }
        currentQuestion = questions[questionIndex]
        questionIndex += 1
    }

    func restart() {
        score = 0
        questionIndex = 0
        generateQuestions()
        nextQuestion()
    }
}
