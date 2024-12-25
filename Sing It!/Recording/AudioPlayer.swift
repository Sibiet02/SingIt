import Foundation
import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    func play(url: URL) {
        stop() 
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Error setting up recording session: \(error)")
        }
    }

    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
