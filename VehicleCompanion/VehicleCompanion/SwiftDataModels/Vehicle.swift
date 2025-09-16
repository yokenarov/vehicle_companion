//
//  Vehicle.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import SwiftData
import Foundation

@Model
final class Vehicle: Identifiable, Equatable {
    var id: UUID { UUID() }
    var name: String
    var make: String
    var model: String
    var year: String
    var vin: String
    var fuelType: FuelType
    @Attribute(.externalStorage) var avatar: Data?

    init(name: String,
         make: String,
         model: String,
         year: String,
         vin: String,
         fuelType: FuelType) {
        self.name = name
        self.make = make
        self.model = model
        self.year = year
        self.vin = vin
        self.fuelType = fuelType
    }

    init() {
        name = ""
        make = ""
        model = ""
        year = ""
        vin = ""
        fuelType = .other
    }

    enum FuelType: Codable {
        case gas
        case diesel
        case electric
        case hybrid
        case other
    }
}
