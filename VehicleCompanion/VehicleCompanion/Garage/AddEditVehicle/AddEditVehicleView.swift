//
//  AddEditVehicleView.swift
//  VehicleCompanion
//
//  Created by Jordan on 16/09/2025.
//

import Foundation
import SwiftUI

enum VehicleFlow {
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

extension VehicleFlow: Identifiable {
    var id: String {
        switch self {
        case .add:
            return "add"
        case .edit(let existing):
            return "edit-\(existing.vin)"
        }
    }
}

extension VehicleFlow: Equatable {
    static func == (lhs: VehicleFlow, rhs: VehicleFlow) -> Bool {
        switch (lhs, rhs) {
        case (.add, .add):
            return true
        case let (.edit(existing1), .edit(existing2)):
            return existing1.vin == existing2.vin
        default:
            return false
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
            AvatarView(imageData: viewModel.vehicle.avatar)
                .onTapGesture { showingImagePicker = true }
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
                            Text(fuel.displayName)
                                .tag(fuel)
                        }
                    }
                    .pickerStyle(.segmented)
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

