//
//  POIRepository.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import Alamofire
import Foundation

struct POIRepository: POIService {
    private let url = "https://api2.roadtrippers.com/api/v2/pois/discover"
    private let parameters: [String: Any] = [
        "sw_corner": "-84.540499,39.079888",
        "ne_corner": "-84.494260,39.113254",
        "page_size": 50,
    ]

    let session: Session

    init(session: Session = AF) {
        self.session = session
    }

    func getPOI() async throws -> POISResponse {
        try await session.request(url, method: .get, parameters: parameters)
            .validate()
            .serializingDecodable(POISResponse.self)
            .value
    }
}
