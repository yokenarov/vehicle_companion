//
//  AddEditVehicleViewModel.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import SwiftUI

@Observable
final class AddEditVehicleViewModel {
    var vehicle: Vehicle
    let vehicleFlow: VehicleFlow
    init(vehicle: Vehicle,
         vehicleFlow: VehicleFlow) {
        self.vehicle = vehicle
        self.vehicleFlow = vehicleFlow
    }

    var canSaveVehicle: Bool {
        vehicle.avatar != nil &&
        !vehicle.name.isEmpty &&
        !vehicle.make.isEmpty &&
        !vehicle.model.isEmpty &&
        !vehicle.year.isEmpty &&
        !vehicle.vin.isEmpty
    }
}
