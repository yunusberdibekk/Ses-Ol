//
//  UnionVoluntarilyPsychologist.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct UnionVoluntarilyPsychologist: View {
    @Environment(\.dismiss) private var dismiss
    var voluntarilyPsychologist: VoluntarilyPsychologistResponseElement
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
                    Text(voluntarilyPsychologist.userName ?? "")
                        .font(.subheadline)
                        .bold()

                    HStack(spacing: 0) {
                        Text("@")
                            .foregroundColor(.spanish_gray)
                        Text(voluntarilyPsychologist.userTel ?? "")
                    }
                        .font(.caption)
                        .foregroundColor(.spanish_gray)

                }
                    .padding(.top, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)

                Text(voluntarilyPsychologist.voluntarilyDesc ?? "")
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
                    Text("Araç durumu: \(voluntarilyPsychologist.voluntarilyVehicleStatus ?? -1)")
                    Text("Talep edilen kurum: \(voluntarilyPsychologist.unionName ?? "")")
                    Text("Konum: \(voluntarilyPsychologist.addressDistrict ?? "")/ \(voluntarilyPsychologist.addressCity ?? "")/\(voluntarilyPsychologist.addressCountry ?? "")")
                    Text("Açık adres: \(voluntarilyPsychologist.fullAddress ?? "")")
                } .foregroundColor(.dark_liver)
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
                        detailViewModel.voluntarily_account_id = voluntarilyPsychologist.voluntarilyAccountID ?? -1
                        Task {
                            await detailViewModel.approveVoluntarilyPsychologist()
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .frame(width: 25, height: 20)
                            .foregroundColor(.green)
                    }

                    Button {
                        detailViewModel.voluntarily_account_id = voluntarilyPsychologist.voluntarilyAccountID ?? -1
                        Task {
                            await detailViewModel.rejectVoluntarilyPsychologist()
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

struct UnionVoluntarilyPsychologist_Previews: PreviewProvider {
    static var previews: some View {
        UnionVoluntarilyPsychologist(voluntarilyPsychologist: VoluntarilyPsychologistResponseElement(voluntarilyAccountID: 1, userName: "Ahmet", userSurname: "Kaya", unionID: 1, unionName: "Afad", userTel: "04234564456", voluntarilyVehicleStatus: 1, voluntarilyDesc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", addressID: 1, addressDistrict: "Merkez", addressCity: "Elazığ", addressCountry: "Türkiye", fullAddress: "Tam adres", voluntarilyApproveStatus: 1))
    }
}
