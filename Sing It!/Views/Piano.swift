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
    var body: some View {
            
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: RecordingListView()) {
                            Image(systemName: "music.note.list")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                        }
                        .accessibilityLabel("Recording List")
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                
                    Text("Sing it!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                    
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
                                    .scaledToFit()
                                    .foregroundColor(audio.recording ? .red : .black)
                                    .frame(width: 45, height: 45)
                                
                                Text(audio.recording ? "Stop Recording" : "Start Recording")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(audio.recording ? .red : .black)
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
