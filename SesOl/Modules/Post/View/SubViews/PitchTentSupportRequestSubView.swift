//
//  PitchTentSupportRequestSubView.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import SwiftUI

struct PitchTentSupportRequestSubView: View {
    @Binding var unionSelectionID: Int
    @Binding var vehicleStatus: Int
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

                Picker("Vasıta durumu", selection: $vehicleStatus) {
                    Text("Yok").tag(0)
                    Text("Var").tag(1)
                }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.halloween_orange)
                    .cornerRadius(25)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextArea(text: $desc, hint: "Gönüllü çadır kurma açıklama.")
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
            }
        }
    }
}

//struct PitchTentSupportRequestSubView_Previews: PreviewProvider {
//    static var previews: some View {
//        PitchTentSupportRequestSubView()
//    }
//}
