//
//  AddEditVehicleView.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import Foundation
import SwiftUI

enum VehicleFlow: Identifiable {
    var id: UUID { UUID() }
    case add
    case edit(existing: Vehicle)

    var screenTitle: String {
        switch self {
        case .add:
            "Add vehicle"
        case .edit:
            "Edit vehicle"
        }
    }

    var buttonTitle: String {
        switch self {
        case .add:
            "Save vehicle"
        case .edit:
            "Update"
        }
    }
}

extension VehicleFlow: View {
    var body: some View {
        switch self {
        case .add:
            AddEditVehicleView(with: .init(vehicle: .init(), vehicleFlow: self))
        case let .edit(vehicle):
            AddEditVehicleView(with: .init(vehicle: vehicle, vehicleFlow: self))
        }
    }
}

private struct AddEditVehicleView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var viewModel: AddEditVehicleViewModel
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    init(with viewModel: AddEditVehicleViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.vehicleFlow.screenTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.clear)
            .padding(.top, 24)
        Form {
            ZStack {
                if let avatarData = viewModel.vehicle.avatar,
                   let uiImage = UIImage(data: avatarData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .onTapGesture { showingImagePicker = true }
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .overlay(
                            Text("Tap to select image")
                                .foregroundColor(.gray)
                                .font(.caption)
                        )
                        .onTapGesture { showingImagePicker = true }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            Group {
                Section(header: Text("Vehicle Info")) {
                    TextField("Name", text: $viewModel.vehicle.name)
                    TextField("Make", text: $viewModel.vehicle.make)
                    TextField("Model", text: $viewModel.vehicle.model)
                    TextField("Year", text: $viewModel.vehicle.year)
                        .keyboardType(.numberPad)
                    TextField("VIN", text: $viewModel.vehicle.vin)
                }
                
                Section(header: Text("Fuel Type")) {
                    Picker("Fuel Type", selection: $viewModel.vehicle.fuelType) {
                        ForEach(Vehicle.FuelType.allCases, id: \.self) { fuel in
                            Text(fuel.displayName).tag(fuel)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .padding(.bottom, 10)
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            Button {
                saveNewVehicle()
                dismiss()
            } label: {
                Text(viewModel.vehicleFlow.buttonTitle)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.canSaveVehicle ? Color.accentColor : Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .disabled(!viewModel.canSaveVehicle)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _, newImage in
            if let newImage {
                viewModel.vehicle.avatar = newImage.jpegData(compressionQuality: 0.8)
            }
        }
    }

    private func saveNewVehicle() {
        if case .add = viewModel.vehicleFlow {
            modelContext.insert(viewModel.vehicle)
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
