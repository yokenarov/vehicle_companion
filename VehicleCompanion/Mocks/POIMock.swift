//
//  POIMock.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

@testable import VehicleCompanion

extension POIService {
    var mock: POIResponse {
        POIResponse(
            id: 101,
            name: "Central Park Café",
            url: "https://example.com/central-park-cafe",
            rating: 4.5,
            loc: [-73.968285, 40.785091],
            primaryCategoryDisplayName: "Café",
            v320x320URL: "https://example.com/images/central-park-cafe-320.jpg",
        )
    }
}

