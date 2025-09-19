//
//  VehicleCardView.swift
//  VehicleCompanion
//
//  Created by Jordan on 19/09/2025.
//

import SwiftUI

struct VehicleCardView: View {
    @Binding var vehicleFlow: VehicleFlow?
    let vehicle: Vehicle

    var body: some View {
        VStack(spacing: 16) {
            AvatarView(imageData: vehicle.avatar)
                .overlay(
                    Button(action: {
                        vehicleFlow = .edit(existing: vehicle)
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 32, height: 32)
                                .shadow(radius: 2)
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                        }
                    }
                    .buttonStyle(.plain)
                    .offset(x: -16, y: -16),
                    alignment: .bottomTrailing
                )
            VStack(alignment: .leading, spacing: 8) {
                Text(vehicle.name.isEmpty ? "Unnamed Vehicle" : vehicle.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                detailRow(label: "Make", value: vehicle.make)
                detailRow(label: "Model", value: vehicle.model)
                detailRow(label: "Year", value: vehicle.year)
                detailRow(label: "VIN", value: vehicle.vin)
                detailRow(label: "Fuel", value: vehicle.fuelType.displayName)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
        }
        .padding(20)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue, lineWidth: 2)
        }
    }

    @ViewBuilder
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value.isEmpty ? "—" : value)
        }
        .font(.body)
    }
}
 
