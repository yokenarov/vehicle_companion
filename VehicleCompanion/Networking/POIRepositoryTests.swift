//
//  POIRepositoryTests.swift
//  VehicleCompanionTests
//
//  Created by Jordan on 16/09/2025.
//

import Alamofire
import Foundation
import Testing
@testable import VehicleCompanion

struct POIRepositoryTests {
    @Test("Success Case")
    func getPOI_success() async throws {
        let json = poiJSONMock.data(using: .utf8)!

        MockURLProtocol.mockData = json
        MockURLProtocol.mockError = nil

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        let repository = makeSUT(with: session)

        let response = try await repository.getPOI()
        #expect(response.pois.count == 1)
        #expect(response.pois.first?.name == "Central Park Café")
        #expect(response.pois.first?.rating == 4.5)
        #expect(response.pois.first?.url == "https://example.com/central-park-cafe")
        #expect(response.pois.first?.loc == [-73.968285, 40.785091])
        #expect(response.pois.first?.primaryCategoryDisplayName == "Café")
        #expect(response.pois.first?.v320x320URL == "https://example.com/images/central-park-cafe-320.jpg")
    }

    @Test("Failure Case (Decoding Error)")
    func getPOI_failure() async throws {
        let invalidJson = """
        { "invalid": "data" }
        """.data(using: .utf8)!

        MockURLProtocol.mockData = invalidJson
        MockURLProtocol.mockError = nil

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        let repository = makeSUT(with: session)

        do {
            _ = try await repository.getPOI()
            Issue.record("Decoding should have failed")
        } catch {
            #expect(true)
        }
    }

    @Test("Failure Case (Network Error)")
    func getPOI_networkError() async throws {
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockError = NSError(domain: "network", code: -1, userInfo: nil)

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)
        let repository = makeSUT(with: session)

        do {
            _ = try await repository.getPOI()
            Issue.record("Network request should have failed")
        } catch {
            #expect(true)
        }
    }
}

private extension POIRepositoryTests {
    func makeSUT(with session: Session) -> POIRepository {
        .init(session: session)
    }
}

extension POIRepositoryTests {
    var poiJSONMock: String {
        """
        { 
        "pois" : [
        {
          "id": 101,
          "name": "Central Park Café",
          "url": "https://example.com/central-park-cafe",
          "rating": 4.5,
          "large_image_url": "https://example.com/images/central-park-cafe-large.jpg",
          "combined_rating_avg": 4.6,
          "loc": [-73.968285, 40.785091],
          "primary_category": "cafe",
          "primary_category_display_name": "Café",
          "category_group": "Food & Drink",
          "tags": ["coffee", "breakfast", "outdoor seating"],
          "v_145x145_url": "https://example.com/images/central-park-cafe-145.jpg",
          "v_320x320_url": "https://example.com/images/central-park-cafe-320.jpg",
          "price": 2,
          "booking_price": 15.0,
          "uber_rating": 5,
          "combined_avg_rating": 4.7,
          "engagement_score": 0.82,
          "booking_url": "https://example.com/book/central-park-cafe",
          "reviews_count": 234,
          "open_now": true,
          "bookable": true,
          "is_chain": false,
          "tpc_id": "cpc-101",
          "allows_pets": true,
          "searchable_price": 14.99,
          "booking_providers": ["OpenTable", "Yelp"],
          "travel_rank": "Top Choice",
          "branding": "Independent",
          "segments": ["casual dining", "coffee shop"]
        }
        ]
        }
        """
    }
}
