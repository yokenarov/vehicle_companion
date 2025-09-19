//
//  AvatarView.swift
//  VehicleCompanion
//
//  Created by Jordan on 19/09/2025.
//

import SwiftUI

struct AvatarView: View {
    private let avatarDiameter: CGFloat = 160
    let imageData: Data?
    @State var showImagePicker: Bool = false
    var body: some View {
        ZStack {
            if let avatarData = imageData,
               let uiImage = UIImage(data: avatarData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarDiameter, height: avatarDiameter)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: avatarDiameter, height: avatarDiameter)
                    .overlay(
                        Text("Tap to select image")
                            .foregroundColor(.gray)
                            .font(.caption)
                    )
            }
        } 
        .padding(.vertical)
    }
}
 
