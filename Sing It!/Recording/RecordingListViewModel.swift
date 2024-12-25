// RecordingListViewModel.swift
import Foundation

class RecordingListViewModel: ObservableObject {
    @Published var recordings: [Recording] = []
    
    func fetchRecordings() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let files = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            self.recordings = files.filter { $0.pathExtension == "m4a" }.map {
                Recording(id: UUID(), fileURL: $0, createdAt: fetchCreationDate(for: $0))
            }.sorted(by: { $0.createdAt > $1.createdAt })
        } catch {
            print("Error fetching recordings: \(error)")
        }
    }
    
    private func fetchCreationDate(for fileURL: URL) -> Date {
        let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path)
        return attributes?[.creationDate] as? Date ?? Date()
    }
}
