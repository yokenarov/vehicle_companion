//
//  VehicleCarouselView.swift
//  VehicleCompanion
//
//  Created by Jordan on 19/09/2025.
//

import SwiftUI

struct VehicleCarouselView: View {
    let vehicles: [Vehicle]
    @Binding var vehicleFlow: VehicleFlow?
    @State private var scrollOffset: CGFloat = 0
    @State private var currentIndex: Int = 0
    private let cardWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    private let spacing: CGFloat = 16
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(vehicles.indices, id: \.self) { index in
                        let vehicle = vehicles[index]
                        VehicleCardView(vehicleFlow: $vehicleFlow, vehicle: vehicle)
                            .frame(width: cardWidth)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.9)
                            .animation(.spring(), value: currentIndex)
                            .onAppear {
                                currentIndex = index
                            }
                    }
                    NoVehiclesView(vehicleFlow: $vehicleFlow)
                        .frame(width: cardWidth)
                        .scaleEffect(currentIndex == vehicles.count ? 1.0 : 0.9)
                        .animation(.spring(), value: currentIndex)
                }
                .padding(.horizontal, (geo.size.width - cardWidth) / 2)
            }
            .content.offset(x: -CGFloat(currentIndex) * (cardWidth + spacing))
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width < -threshold {
                            currentIndex = min(currentIndex + 1, vehicles.count)
                        } else if value.translation.width > threshold {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }
            )
        }
    }
}
