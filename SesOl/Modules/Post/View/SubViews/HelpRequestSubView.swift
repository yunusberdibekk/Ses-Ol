//
//  HelpRequestSubview.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import SwiftUI

struct HelpRequestSubView: View {
    @Binding var selectedUnionID: Int
    @Binding var selectedDisasterID: Int
    @Binding var numOfPerson: Int
    @Binding var requestDesc: String
    @Binding var selectedHelpCategoryID: Int

    var unions: UnionResponse
    var disasters: DisasterResponse
    var supportCategories: SupportCategoriesResponse

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Picker("Kurum adı", selection: $selectedUnionID) {
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
                Picker("Afet kategori", selection: $selectedDisasterID) {
                    Text("Seç").tag(-1)
                    ForEach(disasters, id: \.disasterID) { disaster in
                        Text(disaster.disasterName ?? "").tag(disaster.disasterID ?? -1)
                    }
                }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.halloween_orange)
                    .cornerRadius(25)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                Picker("Destek kategori", selection: $selectedHelpCategoryID) {
                    Text("Seç").tag(-1)
                    ForEach(supportCategories, id: \.categoryID) { category in
                        Text(category.categoryName ?? "").tag(category.categoryID ?? -1)
                    }
                }
                    .pickerStyle(.navigationLink)
                    .foregroundColor(.halloween_orange)
                    .cornerRadius(25)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                Stepper(value: $numOfPerson, in: 0...100) {
                    Text("Talep kişi sayısı: \(numOfPerson)")
                }
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextArea(text: $requestDesc, hint: "Yardım talebi açıklama")
                    .foregroundColor(.halloween_orange)
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
            }
        }
    }
}

//struct HelpRequestSubview_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpRequestSubview()
//    }
//}
