//
//  CircularProgressBarView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

import SwiftUI

struct CircularProgressBarView: View {
    
    @Binding var timeRemaining: Int
    let totalTime: Int
    
    var progress: CGFloat {
        return CGFloat(timeRemaining) / CGFloat(totalTime)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 30)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.2), value: progress)
            
        }
    }
}

#Preview {
    CircularProgressBarView(timeRemaining: .constant(40), totalTime: 60)
}
