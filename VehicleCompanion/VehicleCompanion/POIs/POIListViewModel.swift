//
//  POIListView.swift
//  VehicleCompanion
//
//  Created by Jordan on 19/09/2025.
//

import SwiftUI

enum POIViewAction {
    case onAppear
}

struct POIModel: Identifiable {
    init(_ poiResponse: POIResponse) {
        id = poiResponse.id
        name = poiResponse.name
        url = poiResponse.url
        rating = poiResponse.rating
        loc = poiResponse.loc
        primaryCategoryDisplayName = poiResponse.primaryCategoryDisplayName
        v320x320URL = poiResponse.v320x320URL
    }

    let id: Int
    let name: String
    let url: String
    let rating: Double?
    let loc: [Double]
    let primaryCategoryDisplayName: String?
    let v320x320URL: String?
}

@Observable
class POIListViewModel {
    var pois: [POIModel]
    var failedToLoadPois: Bool = false

    @ObservationIgnored private let poiService: POIService

    init(poiService: POIService = POIRepository()) {
        self.poiService = poiService
        pois = []
    }

    @discardableResult
    func act(upon action: POIViewAction) -> Task<Void, Never> {
        Task { @MainActor in
            switch action {
            case .onAppear:
                do {
                    let poisResponse = try await poiService.getPOI()
                    pois = poisResponse.pois.map { .init($0) }
                } catch {
                    failedToLoadPois = true
                }
            }
        }
    }
}
