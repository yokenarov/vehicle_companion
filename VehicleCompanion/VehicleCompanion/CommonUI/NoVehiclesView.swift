//
//  NoVehiclesView.swift
//  VehicleCompanion
//
//  Created by Jordan on 17/09/2025.
//

import SwiftUI

struct NoVehiclesView: View {
    @Binding var vehicleFlow: VehicleFlow?
    var body: some View {
            VStack(spacing: 24) {
                Spacer()
                Image(systemName: "plus.message.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
                    .shadow(radius: 8)

                Text("If you want to add a vehicle\nYou're just a tap away")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                Spacer()
            }
            .onTapGesture {
                vehicleFlow = .add
            }
            .padding()
    }
}
