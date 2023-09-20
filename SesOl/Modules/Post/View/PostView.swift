//
//  PostView.swift
//  ResimYukleme
//
//  Created by Yunus Emre Berdibek on 28.05.2023.
//
import SwiftUI

struct PostView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var postViewModel = PostViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    Text(postViewModel.isUnionAccount == 1 ? "Kurum Gönderiler" : "Talep Oluştur")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                    .padding([.top, .trailing], PagePaddings.Normal.padding_20.rawValue)

                if postViewModel.isUnionAccount == 1 {
                    VStack {
                        Picker("Seç", selection: $postViewModel.unionSelectedPostOption) {
                            ForEach(UnionPostOptions.allCases, id: \.self) { option in
                                Text(option.description).tag(option)
                            }
                        }
                            .pickerStyle(.segmented)
                            .foregroundColor(.red)
                            .cornerRadius(25)
                            .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                            .padding([.top, .bottom], PagePaddings.Normal.padding_20.rawValue)
                        Spacer()

                        switch postViewModel.unionSelectedPostOption {
                        case .createPost:
                            HStack {
                                TextArea2("Kurum gönderi açıklaması.", text: $postViewModel.unionPostDesc)
                            }
                                .foregroundColor(.spanish_gray)
                                .modifier(TextFieldModifier())
                                .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                                .padding(.trailing, PagePaddings.Normal.padding_20.rawValue)
                                .padding(.top, 40)
                                .padding(.bottom, 50)

                            HStack {
                                Spacer()
                                Button {
                                    Task {
                                        await postViewModel.createPost()
                                    }
                                } label: {
                                    Text("Paylaş")
                                }
                                Spacer()
                            }
                                .alert("Kurum gönderi", isPresented: $postViewModel.createPost, actions: {
                                Button("Tamam", role: .destructive) {
                                    dismiss()
                                }
                            }, message: {
                                    Text("Kurum gönderisi başarılı bir şekilde oluşturulmuştur.")
                                })
                                .foregroundColor(.halloween_orange)
                                .padding(.bottom, 50)
                        case .posts:
                            ScrollView {
                                LazyVStack {
                                    if let posts = postViewModel.unionPosts {
                                        ForEach(posts, id: \.postID) { post in
                                            NavigationLink {
                                                UnionPostDetailView(unionPost: post)
                                                    .navigationBarBackButtonHidden(true)
                                            } label: {
                                                PostRow(post: post)
                                                    .padding(.top, 3)
                                            }.foregroundColor(.dark_liver)
                                        }
                                    } else {
                                        let currentTime = postViewModel.getCurrentTime()

                                        PostRow(post: UnionPostResponseElement(postID: -1, publisherUnionID: -1, postPublisherName: "System", postContent: "Dikkat! Şu anda sistem veri tabanında yayımlanmış kurum post girişi bulunmamaktadır.", postTime: currentTime))
                                    }
                                }
                            }.refreshable {
                                await postViewModel.getUnionPosts()
                            }
                        }
                    }
                } else {
                    Picker("Seç", selection: $postViewModel.citizienSelectedPostOption) {
                        ForEach(CitizienPostOptions.allCases, id: \.self) { option in
                            Text(option.description).tag(option)
                        }
                    }
                        .pickerStyle(.segmented)
                        .foregroundColor(.red)
                        .cornerRadius(25)
                        .padding([.leading, .trailing], PagePaddings.Normal.padding_20.rawValue)
                        .padding([.top, .bottom], PagePaddings.Normal.padding_10.rawValue)


                    switch postViewModel.citizienSelectedPostOption {
                    case .helpRequest:
                        HelpRequestSubView(selectedUnionID: $postViewModel.citizienSelectedUnionID, selectedDisasterID: $postViewModel.citizienSelectedDisasterID, numOfPerson: $postViewModel.citizienNumOfPerson, requestDesc: $postViewModel.citizienDesc, selectedHelpCategoryID: $postViewModel.selectedCategoryID, unions: postViewModel.unions ?? UnionResponse(), disasters: postViewModel.disasters ?? DisasterResponse(), supportCategories: postViewModel.supportCategories ?? SupportCategoriesResponse())

                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    await postViewModel.createHelpRequest()
                                }
                            } label: {
                                Text("Paylaş")
                            }
                            Spacer()
                        }
                            .alert("Yardım talebi", isPresented: $postViewModel.createHelpRequest, actions: {
                            Button("Tamam", role: .destructive) {
//                                dismiss()
                            }
                        }, message: {
                                Text("Yardım talebiniz başarılı bir şekilde oluşturulmuştur.")
                            })
                            .foregroundColor(.halloween_orange)
                            .padding(.top, PagePaddings.Normal.padding_10.rawValue)
                        Spacer().frame(height: 60)
                    case .supportRequest:
                        Picker("Destek türü", selection: $postViewModel.selectedSupportType) {
                            ForEach(SupportType.allCases, id: \.self) { option in
                                Text(option.description).tag(option)
                            }
                        }.pickerStyle(.navigationLink)
                            .foregroundColor(.halloween_orange)
                            .cornerRadius(25)
                            .modifier(TextFieldModifier())
                            .padding(.leading, PagePaddings.Normal.padding_20.rawValue)
                            .padding(.trailing, PagePaddings.Normal.padding_20.rawValue)

                        switch postViewModel.selectedSupportType {
                        case .providingAssistance:
                            DefaultSupportRequestSubView(unionSelectionID: $postViewModel.citizienSelectedUnionID, selectedSupportCategoryId: $postViewModel.selectedCategoryID, numOfPerson: $postViewModel.citizienNumOfPerson, unionTittle: $postViewModel.citizienTittle, unionDesc: $postViewModel.citizienDesc, unions: postViewModel.unions ?? UnionResponse(), supportCategories: postViewModel.supportCategories ?? SupportCategoriesResponse())
                                .alert("Destek talebi", isPresented: $postViewModel.createSupportRequest, actions: {
                                Button("Tamam", role: .destructive) {
//                                    dismiss()
                                }
                            }, message: {
                                    Text("Destek talebiniz başarılı bir şekilde oluşturulmuştur.")
                                })
                        case .psychologist:
                            PsychologistSupportRequestSubView(unionSelectionID: $postViewModel.citizienSelectedUnionID, vehicleStatus: $postViewModel.citizienVehicleStatus, desc: $postViewModel.citizienDesc, unions: postViewModel.unions ?? UnionResponse())
                                .alert("Gönüllü psikolog destek talebi", isPresented: $postViewModel.voluntarilyPsychologist, actions: {
                                Button("Tamam", role: .destructive) {
//                                    dismiss()
                                }
                            }, message: {
                                    Text("Gönüllü psikolog destek talebiniz başarılı bir şekilde oluşturulmuştur.")
                                })
                        case .pitchTent:
                            PitchTentSupportRequestSubView(unionSelectionID: $postViewModel.citizienSelectedUnionID, vehicleStatus: $postViewModel.citizienVehicleStatus, desc: $postViewModel.citizienDesc, unions: postViewModel.unions ?? UnionResponse())
                                .alert("Gönüllü çadır kurma destek talebi", isPresented: $postViewModel.voluntarilyPitchTent, actions: {
                                Button("Tamam", role: .destructive) {
//                                    dismiss()
                                }
                            }, message: {
                                    Text("Gönüllü çadır kurma destek talebiniz başarılı bir şekilde oluşturulmuştur.")
                                })
                        case .transporter:
                            TransporterSupportSubView(unionSelectionID: $postViewModel.citizienSelectedUnionID, fromLocation: $postViewModel.citizienFromLocation, toLocation: $postViewModel.citizienToLocation, numOfVehicle: $postViewModel.citizienVehicleCount, numOfDriver: $postViewModel.citizienDriverCount, desc: $postViewModel.citizienDesc, unions: postViewModel.unions ?? UnionResponse())
                                .alert("Gönüllü taşımacılık destek talebi", isPresented: $postViewModel.voluntarilyTransporter, actions: {
                                Button("Tamam", role: .destructive) {
//                                    dismiss()
                                }
                            }, message: {
                                    Text("Gönüllü taşımacılık destek talebiniz başarılı bir şekilde oluşturulmuştur.")
                                })
                        }

                        HStack {
                            Spacer()
                            Button {
                                Task {
                                    switch postViewModel.selectedSupportType {
                                    case .providingAssistance:
                                        await postViewModel.createProvidingAssistance()

                                    case .psychologist:
                                        await postViewModel.createVoluntarilyPsychologist()

                                    case .pitchTent:
                                        await postViewModel.createVoluntarilyPitchTent()

                                    case .transporter:
                                        await postViewModel.createVoluntarilyTransporter()
                                    }
                                }
                            } label: {
                                Text("Paylaş")
                            }
                            Spacer()
                        }
                            .foregroundColor(.halloween_orange)
                            .padding(.top, PagePaddings.Normal.padding_10.rawValue)
                        Spacer()

                    }
                }
                Spacer()
            }
                .onAppear {
                postViewModel.readCache(userIdKey: .userId, isUnionKey: .isUnionAccount)
                Task {
                    await postViewModel.readCitizienProfile()
                    if postViewModel.isUnionAccount == 0 {
                        await postViewModel.getUnions()
                        await postViewModel.getDisasters()
                        await postViewModel.getSupportCategories()
                    } else {
                        await postViewModel.getUnionPosts()
                    }

                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
