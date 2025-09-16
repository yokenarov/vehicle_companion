//
//  POIResponse.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import Foundation
import Foundation

struct POISResponse: Decodable {
    let pois: [POIResponse]
}

struct POIResponse: Decodable {
    let id: Int
    let name: String
    let url: String
    let rating: Double?
    let loc: [Double]
    let primaryCategoryDisplayName: String?
    let v320x320URL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case rating
        case loc
        case primaryCategoryDisplayName = "primary_category_display_name"
        case v320x320URL = "v_320x320_url"
    }
}
