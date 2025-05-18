//
//  ContentView.swift
//  WaterReminder
//
//  Created by DigitalOasisID on 18/05/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkStore: NetworkStore
    var body: some View {
        if networkStore.isConnected {
            CountdownScreenView()
        } else {
            Text("Network is unavailable")
        }
    }
}

#Preview {
    ContentView()
}
