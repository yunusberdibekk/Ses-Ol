//
//  UnionVoluntarilyTransporter.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct UnionVoluntarilyTransporter: View {
    @Environment(\.dismiss) private var dismiss
    var voluntarilTransporter: VoluntarilyTransporterResponseElement
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
                    Text(voluntarilTransporter.userName ?? "")
                        .font(.subheadline)
                        .bold()

                    HStack(spacing: 0) {
                        Text("@")
                            .foregroundColor(.spanish_gray)
                        Text(voluntarilTransporter.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)

                }
                    .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_10.rawValue)

                Text(voluntarilTransporter.voluntarilyDEC ?? "")
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
                    Text("Araç sayısı: \(voluntarilTransporter.voluntarilyNumVehicle ?? -1)")
                    Text("Şoför sayısı: \(voluntarilTransporter.voluntarilyNumDriver ?? -1)")
                    Text("Alınacak konum: \(voluntarilTransporter.voluntarilyFromLocation ?? "")")
                    Text("Bıraklılacak konum: \(voluntarilTransporter.voluntarilyToLocation ?? "")")

                    Text("Talep edilen kurum: \(voluntarilTransporter.unionName ?? "")")
                    Text("Konum: \(voluntarilTransporter.addressDistrict ?? "")/ \(voluntarilTransporter.addressCity ?? "")/\(voluntarilTransporter.addressCountry ?? "")")
                    Text("Açık adres: \(voluntarilTransporter.fullAddress ?? "")")
                }
                    .foregroundColor(.dark_liver)
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

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        detailViewModel.voluntarily_account_id = voluntarilTransporter.voluntarilyAccountID ?? -1
                        Task {
                            await detailViewModel.approveVoluntarilyTransporter()
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .frame(width: 25, height: 20)
                            .foregroundColor(.green)
                    }

                    Button {
                        detailViewModel.voluntarily_account_id = voluntarilTransporter.voluntarilyAccountID ?? -1
                        Task {
                            await detailViewModel.rejectVoluntarilyTransporter()
                            dismiss()
                        } } label: {
                        Image(systemName: "multiply")
                            .frame(width: 25, height: 20)
                            .foregroundColor(.red)
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

struct UnionVoluntarilyTransporter_Previews: PreviewProvider {
    static var previews: some View {
        UnionVoluntarilyTransporter(voluntarilTransporter: VoluntarilyTransporterResponseElement(voluntarilyAccountID: 1, userName: "Ahmet", userSurname: "Kaya", userTel: "04564354432", unionID: 1, unionName: "Afad", voluntarilyFromLocation: "Elazığ", voluntarilyToLocation: "Malatya", voluntarilyNumDriver: 1, voluntarilyNumVehicle: 1, voluntarilyDEC: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Exce", addressID: 1, addressDistrict: "Merkez", addressCity: "Elazığ", addressCountry: "Türkiye", fullAddress: "Tam adres", voluntarilyApproveStatus: 1))
    }
}
