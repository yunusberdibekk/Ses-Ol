//
//  SOCitizienCreateView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 20.12.2023.
//

import SwiftUI

struct SOCitizienCreateView: View {
    @EnvironmentObject var viewModel: SOCreateViewModel

    var body: some View {
        Form {
            requestType
            switch viewModel.selectedRequestType {
            case .help:
                unionsList
                disastersList
                helpRequestCategories
                numOfPersons
                requestDesc
            case .support:
                requestCategories
                unionsList
                switch viewModel.selectedSupportRequestType {
                case .standart:
                    numOfPersons
                    requestTitle
                    requestDesc
                case .psyhlogist:
                    vehicleStatus
                    requestDesc
                case .pitchtent:
                    vehicleStatus
                    requestDesc
                case .transporter:
                    transporterInfoField(title: "KALKIŞ NOKTASI", text: $viewModel.fromLocation)
                    transporterInfoField(title: "VARIŞ NOKTASI", text: $viewModel.toLocation)
                    transporterInfoField(title: "ARAÇ SAYISI", text: $viewModel.numOfCars)
                    transporterInfoField(title: "ŞOFÖR SAYISI", text: $viewModel.numOfDrivers)
                    requestDesc
                }
            }
            Button("Share") {
                print("basıldı")
                Task {
                    await viewModel.createRequest()
                }
            }
            .modifier(DefaultListButtonModifier(backgroundColor: .blue))
        }
    }

    private var requestType: some View {
        Section {
            Picker("Seç", selection: $viewModel.selectedRequestType) {
                ForEach(RequestTypes.allCases, id: \.self) {
                    Text("\($0.title)")
                        .tag($0)
                }
            }
        } header: {
            Text("TALEP TÜRÜ")
        }
    }
    
    private var unionsList: some View {
        Section {
            Picker("Seç", selection: $viewModel.selectedUnion) {
                ForEach(viewModel.unions, id: \.self) {
                    Text($0.unionName)
                        .tag($0)
                }
            }
        } header: {
            Text("KURUM ADI")
        }
    }
    
    private var disastersList: some View {
        Section {
            Picker("Seç", selection: $viewModel.selectedDisaster) {
                ForEach(viewModel.disasters, id: \.self) {
                    Text($0.disasterName)
                        .tag($0)
                }
            }
        } header: {
            Text("AFET TÜRÜ")
        }
    }
    
    private var createButton: some View {
        Button("Share") {
            Task {}
        }
        .modifier(DefaultListButtonModifier(backgroundColor: .blue))
    }
    
    private var helpRequestCategories: some View {
        Section {
            Picker("Seç", selection: $viewModel.selectedHelpRequestType) {
                ForEach(viewModel.helpRequestCategories, id: \.categoryID) {
                    Text($0.categoryName)
                }
            }
        } header: {
            Text("YARDIM TALEBİ KATEGORİSİ")
        }
    }
    
    private var numOfPersons: some View {
        Section {
            Stepper(viewModel.numOfPersons.description, value: $viewModel.numOfPersons)
        } header: {
            Text("YARDIM TALEBİ KİŞİ SAYISI")
        }
    }
    
    private var requestDesc: some View {
        Section {
            TextEditor(text: $viewModel.requestDesc)
        } header: {
            Text("TALEP AÇIKLAMASI")
        }
    }
    
    private var vehicleStatus: some View {
        Section {
            Picker("Sec", selection: $viewModel.vehicleStatus) {
                Text("Var")
                    .tag(true)
                Text("Yok")
                    .tag(false)
            }
        } header: {
            Text("Vasıta Durumu")
        }
    }
    
    private var requestCategories: some View {
        Section {
            Picker("Seç", selection: $viewModel.selectedSupportRequestType) {
                ForEach(SupportRequestTypes.allCases, id: \.self) {
                    Text($0.title)
                }
            }
        } header: {
            Text("DESTEK TÜRÜ")
        }
    }
    
    private var requestTitle: some View {
        Section {
            TextField("", text: $viewModel.requestTitle)
        } header: {
            Text("TALEP BAŞLIK")
        }
    }
    
    private func transporterInfoField(title: String, text: Binding<String>) -> some View {
        Section {
            TextField("", text: text)
        } header: {
            Text(title)
        }
    }
}

#Preview {
    SOCitizienCreateView()
        .environmentObject(SOCreateViewModel())
}
