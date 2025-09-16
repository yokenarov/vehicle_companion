//
//  POIService.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import Foundation

protocol POIService {
    func getPOI() async throws -> POISResponse
}
