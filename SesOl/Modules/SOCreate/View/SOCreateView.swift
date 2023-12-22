//
//  SOPostView.swift
//  ResimYukleme
//
//  Created by Yunus Emre Berdibek on 28.05.2023.
//
import SwiftUI

struct SOCreateView: View {
    @StateObject var viewModel: SOCreateViewModel = .init()

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.userType {
                case .citizien:
                    SOCitizienCreateView()
                        .environmentObject(viewModel)
                case .union:
                    SOUnionCreateView()
                        .environmentObject(viewModel)
                }
            }
            .navigationTitle("Gönderi Yönetim")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await viewModel.fetchAdditionalUnionPosts()
                }
            }
            .alert("Dikkat!", isPresented: $viewModel.logStatus) {
                Text(viewModel.logMessage)
                Button("Tamam", role: .cancel) {}
            }
        }
    }
}

#Preview {
    SOCreateView()
        .environmentObject(SOCreateViewModel())
}
