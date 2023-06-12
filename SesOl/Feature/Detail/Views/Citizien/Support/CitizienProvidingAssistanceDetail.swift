//
//  CitizienSupportRequestDetail.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 26.05.2023.
//

import SwiftUI

struct CitizienProvidingAssistanceDetail: View {
    @Environment(\.dismiss) private var dismiss
    internal var providingAssistance: ProvidingAssistanceResponseElement
    internal var detailViewModel: DetailViewModel = DetailViewModel()

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
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)

                Text(providingAssistance.assistanceTitle ?? "")
                    .foregroundColor(.halloween_orange)
                    .font(.subheadline)
                    .bold()
                    .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.leading, 20)
                    .padding(.bottom, 5)
                Text(providingAssistance.assistanceDescription ?? "")
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
                    Text("Talep edilen kurum: \(providingAssistance.assistanceSentUnionName ?? "")")
                    Text("Talep kategori: \(providingAssistance.assistanceCategoryName ?? "")")
                    Text("Destek kişi sayısı: \(providingAssistance.assistanceNumOfPerson ?? 0)")
                    Text("Konum: \(providingAssistance.addressDistrict ?? "")/ \(providingAssistance.addressCity ?? "")/\(providingAssistance.addressCountry ?? "")")
                    Text("Açık adres: \(providingAssistance.fullAddress ?? "")")
                }
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)
            }
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.halloween_orange)
                    }

                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        detailViewModel.assistance_id = providingAssistance.assistanceID ?? -1

                        Task {
                            await detailViewModel.deleteSupportRequest()
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.halloween_orange)
                    }
                }
            }   .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
        }
    }
}

struct CitizienSupportRequestDetail_Previews: PreviewProvider {
    static var previews: some View {
        CitizienProvidingAssistanceDetail(providingAssistance: ProvidingAssistanceResponseElement(assistanceID: -1, assistanceTitle: "Sistem Mesajı", assistanceSentUnionID: 1, assistanceSentUnionName: "Afad", assistanceUserAccountID: -1, userTel: "XXXXXXXXXX", assistanceNumOfPerson: 0, assistanceCategoryID: -1, assistanceCategoryName: "", asistanceStatus: -1, assistanceDescription: "Veritabanında ilgili veri kayıdı bulunmamaktadır.", fullname: "Sistem", addressID: -1, addressDistrict: "", addressCity: "", addressCountry: "", fullAddress: "", assistanceStatus: -1))
    }
}
