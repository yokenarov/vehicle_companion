//
//  POIListView.swift
//  VehicleCompanion
//
//  Created by Jordan on 19/09/2025.
//

import SwiftUI

struct POIListView: View {
    @State var viewModel: POIListViewModel = .init()

    var body: some View {
        GradientBackground {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.pois) { poi in
                        NavigationLink(destination: POIDetailView(poi: poi)) {
                            Text(poi.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(Color.blue, lineWidth: 1)
                                }
                        }
                    }
                }
            }
            .padding(16)
        }
        .onAppear {
            viewModel.act(upon: .onAppear)
        }
        .navigationBarTitle("POIs")
    }
}

struct POIDetailView: View {
    let poi: POIModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image if available
                if let imageUrl = poi.v320x320URL,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Name
                Text(poi.name)
                    .font(.title)
                    .fontWeight(.bold)

                // Category
                if let category = poi.primaryCategoryDisplayName {
                    Text(category)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Rating
                if let rating = poi.rating {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                    }
                }

                // URL
                Link(destination: URL(string: poi.url)!) {
                    Label("View Website", systemImage: "link")
                }
                .padding(.top, 8)

                // Location coordinates
                if !poi.loc.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.headline)
                        Text("Lat: \(poi.loc.first ?? 0), Lng: \(poi.loc.last ?? 0)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(poi.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
