//
//  GradientBackground.swift
//  VehicleCompanion
//
//  Created by Jordan on 17/09/2025.
//

import SwiftUI

struct GradientBackground<V: View>: View {
    var content: (() -> V)?
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            content?()
        }
    }
}
