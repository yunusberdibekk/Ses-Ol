//
//  VoluntarilyPsychologist.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct CitizienVoluntarilyPsychologist: View {
    @Environment(\.dismiss) private var dismiss
    var voluntarilyPsychologist: VoluntarilyPsychologistResponseElement
    internal var detailViewModel: DetailViewModel = DetailViewModel()

    @State var delete = false

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
                    .padding(.bottom, PagePaddings.Normal.padding_10.rawValue)

                Text(voluntarilyPsychologist.voluntarilyDesc ?? "")
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
                }
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)
            }
                .alert("Sil", isPresented: $delete, actions: {
                Button("Sil", role: .destructive) {
                    Task {
                        await detailViewModel.deleteVoluntarilyPsychologist()
                    }
                    dismiss()
                }

                Button("İptal", role: .cancel) {
                    print("İptal")
                }
            }, message: {
                    Text("Silmek istediğinize emin misiniz ?")
                })
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
                        detailViewModel.readCache(userIdKey: .userId, isUnionKey: .isUnionAccount)
                        delete.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.halloween_orange)
                    }
                }
            } .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                .padding(.all, PagePaddings.Normal.padding_20.rawValue)
        }
    }
}

//struct VoluntarilyPsychologist_Previews: PreviewProvider {
//    static var previews: some View {
//        VoluntarilyPsychologist()
//    }
//}
