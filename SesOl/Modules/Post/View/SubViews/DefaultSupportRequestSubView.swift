//
//  DefaultSupportRequestSubview.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 19.09.2023.
//

import SwiftUI

struct DefaultSupportRequestSubView: View {
    @Binding var unionSelectionID: Int
    @Binding var selectedSupportCategoryId: Int
    @Binding var numOfPerson: Int
    @Binding var unionTittle: String
    @Binding var unionDesc: String

    var unions: UnionResponse
    var supportCategories: SupportCategoriesResponse

    var body: some View {
        NavigationStack {
            VStack(spacing: 19) {
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
                Picker("Destek kategori", selection: $selectedSupportCategoryId) {
                    Text("Seç").tag(-1)
                    ForEach(supportCategories, id: \.categoryID) { category in
                        Text(category.categoryName ?? "").tag(category.categoryID ?? 1)
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
                TextField("Başlık", text: $unionTittle)
                    .foregroundColor(.halloween_orange)
                    .modifier(TextFieldModifier())
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                TextArea(text: $unionDesc, hint: "Destek talebi açıklama")
                    .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
            }
        }
    }
}

//struct DefaultSupportRequestSubview_Previews: PreviewProvider {
//    static var previews: some View {
//        DefaultSupportRequestSubview()
//    }
//}
