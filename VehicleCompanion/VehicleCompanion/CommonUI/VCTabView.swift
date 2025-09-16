//
//  VCTabView.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import SwiftUI

struct VCTabView: View {
    @State private var selectedTab: Tab = .garage
    var body: some View {
        TabView(selection: $selectedTab) {
            Text(Tab.garage.title)
                .tabItem {
                    Label(Tab.garage.title, systemImage: Tab.garage.image)
                }
            Text(Tab.pois.title)
                .tabItem {
                    Label(Tab.pois.title, systemImage: Tab.pois.image)
                }
        }
    }
}

enum Tab: Hashable {
    case garage
    case pois

    var title: String {
        switch self {
        case .garage:
            "Garage"
        case .pois:
            "Places"
        }
    }

    var image: String {
        switch self {
        case .garage:
            "car"
        case .pois:
            "point.bottomleft.forward.to.point.topright.filled.scurvepath"
        }
    }
}
