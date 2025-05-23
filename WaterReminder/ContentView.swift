//
//  ContentView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkStore: NetworkStore
    @State private var showHistory: Bool = false
    @State private var window: NSWindow?
    
    
    var body: some View {
        if networkStore.isConnected {
            VStack {
                if showHistory {
                    GeometryReader { geometry in
                        HStack {
                            CountdownScreenView(showHistory: $showHistory)
                                .frame(width: geometry.size.width * 0.4)
                            HistoryScreenView()
                                .frame(width: geometry.size.width * 0.6,
                                       height: geometry.size.height)
                        }
                        
                    }
                } else {
                    CountdownScreenView(showHistory: $showHistory)
                }
            }
            .background(
                WindowAccessor { win in
                    self.window = win
                }
            ).onChange(of: showHistory) {
                resizeWindow()
            }
        } else {
            Text("Network is unavailable")
        }
    }
    
    private func resizeWindow() {
        guard let window = window else { return }
        var frame = window.frame
        let newWidth: CGFloat = showHistory ? 800 : 400
        let delta = newWidth - frame.width
        frame.origin.x -= delta/2
        frame.size.width = newWidth
        
        window.setFrame(frame, display: true, animate: true)
        
    }
}

#Preview {
    ContentView()
}
