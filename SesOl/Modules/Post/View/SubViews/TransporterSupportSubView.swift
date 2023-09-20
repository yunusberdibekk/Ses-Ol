//
//  TransporterSupportSubview.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import SwiftUI

struct TransporterSupportSubView: View {
    @Binding var unionSelectionID: Int
    @Binding var fromLocation: String
    @Binding var toLocation: String
    @Binding var numOfVehicle: String
    @Binding var numOfDriver: String
    @Binding var desc: String

    var unions: UnionResponse
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Picker("Kurum adı", selection: $unionSelectionID) {
                    Text("Seç").tag(-1)
                    ForEach(unions, id: \.unionID) { union in
                        Text(union.unionName ?? "").tag(union.unionID ?? -1)
                    }
                }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.halloween_orange)
                    .cornerRadius(25)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextField("Alınacak konum", text: $fromLocation)
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextField("Bırakılacak konum", text: $toLocation)
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextField("Vasıta sayısı", text: $numOfVehicle)
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextField("Şoför sayısı", text: $numOfDriver)
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                LargeTextField(text: $desc, hint: "Gönüllü taşımacılık açıklama.")
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
            }
        }
    }
}

//struct TransporterSupportSubview_Previews: PreviewProvider {
//    static var previews: some View {
//        TransporterSupportSubview()
//    }
//}
