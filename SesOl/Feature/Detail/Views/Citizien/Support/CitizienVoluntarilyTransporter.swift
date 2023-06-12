//
//  CitizienVoluntarilyTransporter.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 31.05.2023.
//

import SwiftUI

struct CitizienVoluntarilyTransporter: View {
    @Environment(\.dismiss) private var dismiss
    var voluntarilTransporter: VoluntarilyTransporterResponseElement
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
                    .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                    .padding(.bottom, PagePaddings.Normal.padding_20.rawValue)
            }
                .alert("Sil", isPresented: $delete, actions: {
                Button("Sil", role: .destructive) {
                    Task {
                        await detailViewModel.deleteVoluntarilyTransporter()
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

//struct CitizienVoluntarilyTransporter_Previews: PreviewProvider {
//    static var previews: some View {
//        CitizienVoluntarilyTransporter()
//    }
//}
