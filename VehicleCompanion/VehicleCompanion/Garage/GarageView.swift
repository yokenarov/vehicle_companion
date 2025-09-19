//
//  GarageView.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import SwiftData
import SwiftUI

struct GarageView: View {
    @State private var vehicleFlow: VehicleFlow?
    @Query var vehicles: [Vehicle]

    var body: some View {
        GradientBackground {
            VStack {
                vehicleView
            }
            .sheet(item: $vehicleFlow, content: {
                $0
                    .presentationDragIndicator(.visible)
            }) 
        }
    }
}

private extension GarageView {
    @ViewBuilder var vehicleView: some View {
        VehicleCarouselView(vehicles: vehicles,
                            vehicleFlow: $vehicleFlow)
    }
}

