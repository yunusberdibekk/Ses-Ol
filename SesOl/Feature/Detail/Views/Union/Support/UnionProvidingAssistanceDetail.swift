//
//  UnionSupportRequestDetail.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 27.05.2023.
//

import SwiftUI

struct UnionProvidingAssistanceDetail: View {
    @Environment(\.dismiss) private var dismiss
    internal var providingAssistance: ProvidingAssistanceResponseElement
    @StateObject private var detailViewModel = DetailViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.halloween_orange)
                    Text(providingAssistance.fullname ?? "")
                        .font(.subheadline)
                        .bold()

                    HStack(spacing: 0) {
                        Text("@")
                            .foregroundColor(.spanish_gray)
                        Text(providingAssistance.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)

                }
                    .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_10.rawValue)

                Text(providingAssistance.assistanceTitle ?? "")
                    .foregroundColor(.halloween_orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 25)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, 5)
                Text(providingAssistance.assistanceDescription ?? "")
                    .foregroundColor(.dark_liver)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.trailing)

                Divider().padding(.all, PagePaddings.Normal.padding_20.rawValue)

                Text("Talep Detayları")
                    .foregroundColor(.halloween_orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, 5)

                VStack(alignment: .leading, spacing: 5) {

                    Text("Talep id: \(providingAssistance.assistanceID ?? -1)")
                    Text("Talep kategori: \(providingAssistance.assistanceSentUnionName?.uppercased() ?? "")")
                    Text("Talep kategori: \(providingAssistance.assistanceCategoryName ?? "")")
                    Text("Destek kişi sayısı: \(providingAssistance.assistanceNumOfPerson ?? 0)")
                    Text("Konum: \(providingAssistance.addressDistrict ?? "")/ \(providingAssistance.addressCity ?? "")/\(providingAssistance.addressCountry ?? "")")
                    Text("Açık adres: \(providingAssistance.fullAddress ?? "")")
                }
                    .foregroundColor(.dark_liver)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.halloween_orange)
                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            detailViewModel.assistance_id = providingAssistance.assistanceID!
                            Task {
                                await detailViewModel.approveSupportRequest()
                                dismiss()
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .frame(width: 25, height: 20)
                                .foregroundColor(.green)
                        }

                        Button {
                            detailViewModel.assistance_id = providingAssistance.assistanceID!
                            Task {
                                await detailViewModel.rejectSupportRequest()
                                dismiss()
                            } } label: {
                            Image(systemName: "multiply")
                                .frame(width: 25, height: 20)
                                .foregroundColor(.red)
                        }
                    }
                }
            }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
        }
    }
}

struct UnionSupportRequestDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnionProvidingAssistanceDetail(providingAssistance: ProvidingAssistanceResponseElement(assistanceID: -1, assistanceTitle: "Tittle", assistanceSentUnionID: 1, assistanceSentUnionName: "Afad", assistanceUserAccountID: -1, userTel: "XXXXXXXXXX", assistanceNumOfPerson: 0, assistanceCategoryID: -1, assistanceCategoryName: "", asistanceStatus: -1, assistanceDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", fullname: "Sistem", addressID: -1, addressDistrict: "Merkez", addressCity: "Elazığ", addressCountry: "Türkiye", fullAddress: "Açık adres", assistanceStatus: -1))
    }
}
