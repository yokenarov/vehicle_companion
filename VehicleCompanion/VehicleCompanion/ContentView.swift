//
//  ContentView.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VCTabView()
    }
}
