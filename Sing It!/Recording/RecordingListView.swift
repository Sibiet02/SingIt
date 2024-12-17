import SwiftUI

struct RecordingListView: View {
    @StateObject private var viewModel = RecordingListViewModel()
    @StateObject private var audioPlayer = AudioPlayer()
    
    @State private var currentlyPlayingURL: URL?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Recordings")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.top, 10)
                
                List {
                    ForEach(viewModel.recordings) { recording in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(recording.fileURL.lastPathComponent)
                                    .font(.headline)
                                Text(formatDate(recording.createdAt))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                handlePlayPause(for: recording.fileURL)
                            }) {
                                Image(systemName: currentlyPlayingURL == recording.fileURL ? "stop.fill" : "play.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: deleteRecording)
                }
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    viewModel.fetchRecordings()
                }
            }
        }
    }

    private func handlePlayPause(for url: URL) {
        if currentlyPlayingURL == url {
            audioPlayer.stop()
            currentlyPlayingURL = nil
        } else {
            audioPlayer.play(url: url)
            currentlyPlayingURL = url
        }
    }

    private func deleteRecording(at offsets: IndexSet) {
        offsets.forEach { index in
            let recording = viewModel.recordings[index]
            
            do {
                try FileManager.default.removeItem(at: recording.fileURL)
                viewModel.recordings.remove(at: index) 
            } catch {
                print("Errore durante l'eliminazione della registrazione: \(error)")
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
