//
//  Home.swift
//  SingIt!-Final
//
//  Created by Silvia Esposito on 15/12/24.
//

import SwiftUI
import Combine

struct Piano: View {
    @ObservedObject var audio: AudioRecorder
    @State private var selectedNote: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecordingListView()) {
                            Image(systemName: "music.note.list")
                                .resizable()
                                .bold()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red.opacity(0.9))
                        }
                        .accessibilityLabel("Recording List")
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                
                    Text("Sing it!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    
                    NoteFlashcardView()
                    
                    Keyboard(selectedNote: $selectedNote)
                        .padding(.bottom, 20)
                        
                    
                    VStack {
                        Button(action: {
                            if audio.recording {
                                audio.stopRecording()
                            } else {
                                audio.startRecording()
                            }
                        })
                        {
                            VStack {
                                Image(systemName: "mic.circle.fill")
                                    .resizable()
                                    .bold()
                                    .scaledToFit()
                                    .foregroundColor(audio.recording ? .red.opacity(0.9) : (colorScheme == .dark ? .white : .black))
                                    .frame(width: 45, height: 45)
                                
                                Text(audio.recording ? "Stop Recording" : "Start Recording")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(audio.recording ? .red.opacity(0.9) : (colorScheme == .dark ? .white : .black))
                            }
                               }
                            }
                    .padding(.bottom, 50)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
        }
#Preview {
    Piano(audio: AudioRecorder())
}
