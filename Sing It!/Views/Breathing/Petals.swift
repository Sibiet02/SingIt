//
//  Petals.swift
//  SingIt!-Final
//
//  Created by Silvia Esposito on 16/12/24.
//
import Foundation
import SwiftUI

let gradient = LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .top, endPoint: .bottom)
let maskGradient = LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .top, endPoint: .bottom)

let maxSize: CGFloat = 120
let minSize: CGFloat = 30
let inhaleTime: Double = 5
let exhaleTime: Double = 3
let pauseTime: Double = 2

let numberOfPetals = 4
let bigAngle = 360.0 / Double(numberOfPetals)
let smallAngle = bigAngle / 2

let ghostMaxSize: CGFloat = maxSize * 0.99
let ghostMinSize: CGFloat = maxSize * 0.95


struct Petals: View {
    let size: CGFloat
    let inhaling: Bool
    var isMask = false
    var body: some View {
        let petalsGradient = isMask ? maskGradient : gradient
        
        ZStack {
            ForEach(0 ..< numberOfPetals) { index in
                petalsGradient
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .mask(
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: size, height: size)
                            .offset(x: inhaling ? size * 0.5 : 0)
                            .rotationEffect(.degrees(Double(bigAngle * Double (index))))
                        )
                    .blendMode(isMask ? .normal : .screen)
            }
        }
    }
}

