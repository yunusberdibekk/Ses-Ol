//
//  PostViewModel.swift
//  SesOl
//
//  Created by Yunus Emre Berdibek on 29.05.2023.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var selectedSupportType: SupportType = .providingAssistance
    @Published var unionSelectedPostOption: UnionPostOptions = .createPost
    @Published var citizienSelectedPostOption: CitizienPostOptions = .helpRequest

    @Published var userID: Int = -1
    @Published var isUnionAccount: Int = -1
    @Published var adressId: Int = -1

    @Published var unionPosts: [UnionPostResponseElement] = []
    @Published var unions: [UnionPostResponseElement] = []
    @Published var supportCategories: SupportCategoriesResponse = []
    @Published var disasters: DisasterResponse?

    @Published var unionPostDesc: String = ""
    @Published var citizienSelectedUnionID: Int = -1
    @Published var citizienSelectedDisasterID: Int = -1
    @Published var citizienNumOfPerson: Int = 0
    @Published var citizienDesc: String = ""
    @Published var selectedCategoryID: Int = -1
    @Published var citizienVehicleStatus: Int = 0
    @Published var citizienFromLocation: String = ""
    @Published var citizienToLocation: String = ""
    @Published var citizienVehicleCount: String = ""
    @Published var citizienDriverCount: String = ""
    @Published var citizienTittle: String = ""

    @Published var createHelpRequest: Bool = false
    @Published var createSupportRequest: Bool = false
    @Published var createPost: Bool = false
    @Published var voluntarilyPsychologist: Bool = false
    @Published var voluntarilyPitchTent: Bool = false
    @Published var voluntarilyTransporter: Bool = false

    @Published var errorMessage: NetworkError?

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func getUnionPosts() async {
        let response = await NetworkManager.shared.post(url: .unionPostCrud, method: .post, model: UnionPostRequest(method: RequestMethods.read_post.rawValue), type: [UnionPostResponseElement].self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.unionPosts = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func parseUnionPost(response: [UnionPostResponseElement]) -> [UnionPostResponseElement] {
        var postlar = [UnionPostResponseElement]()

        for post in response {
            if post.publisherUnionID == userID {
                postlar.append(post)
            }
        }
        return postlar
    }

    func readCitizienProfile() async {
        let response = await NetworkManager.shared.post(url: .usersCrud, method: .post, model: CitizienProfileRequest(method: RequestMethods.read_user.rawValue, user_account_id: userID), type: CitizienProfileResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let adresID = success.addressID {
                    self.adressId = adresID
                }

            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getUnions() async {
        let response = await NetworkManager.shared.post(url: .unionsCrud, method: .post, model: UnionRequest(method: RequestMethods.get_all_unions.rawValue), type: [UnionPostResponseElement].self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.unions = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getSupportCategories() async {
        let response = await NetworkManager.shared.fetch(url: .getRequirement, method: .get, type: SupportCategoriesResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.supportCategories = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func getDisasters() async {
        let response = await NetworkManager.shared.fetch(url: .getDisaster, method: .get, type: DisasterResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                self.disasters = success
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createHelpRequest() async {
        let response = await NetworkManager.shared.post(url: .requestCrud, method: .post, model: CreateUserRequest(method: RequestMethods.create_request.rawValue, request_account_id: userID, num_of_person: citizienNumOfPerson, request_disaster_id: citizienSelectedDisasterID, request_union_id: citizienSelectedUnionID, request_category: selectedCategoryID, request_desc: citizienDesc), type: CreateUserHelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.createHelpRequest = true
                        self.citizienNumOfPerson = 0
                        self.citizienDesc = ""
                    } else {
                        self.createHelpRequest = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createProvidingAssistance() async {
        let response = await NetworkManager.shared.post(url: .providingAssistanceCrud, method: .post, model: CreateSupportRequest(method: RequestMethods.create_assistance.rawValue, user_assistance_account_id: userID, assistance_title: citizienTittle, assistance_sent_union_id: citizienSelectedUnionID, assistance_num_of_person: citizienNumOfPerson, assistance_category_id: selectedCategoryID, assistance_desc: citizienDesc, assistance_address_id: adressId, is_a_union: isUnionAccount), type: CreateUserHelpRequestResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.createSupportRequest = true
                        self.citizienNumOfPerson = 0
                        self.citizienDesc = ""
                    } else {
                        self.createSupportRequest = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createPost() async {
        let response = await NetworkManager.shared.post(url: .unionPostCrud, method: .post, model: CreatePostRequest(method: RequestMethods.create_post.rawValue, post_publisher_id: userID, post_content: unionPostDesc), type: CreatePostResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.createPost = true
                    } else {
                        self.createPost = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createVoluntarilyPsychologist() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPsychologist, method: .post, model: CreateVoluntarilyPsychologistRequest(method: RequestMethods.create_voluntarily.rawValue, user_account_id: userID, voluntarily_union_id: citizienSelectedUnionID, voluntarily_vehicle_status: citizienVehicleStatus, voluntarily_desc: citizienDesc), type: CreateVoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.citizienVehicleStatus = 0
                        self.citizienDesc = ""
                        self.voluntarilyPsychologist = true
                    } else {
                        self.voluntarilyPsychologist = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createVoluntarilyPitchTent() async {
        let response = await NetworkManager.shared.post(url: .voluntarilyPitchTent, method: .post, model: CreateVoluntarilyPitchTentRequest(method: RequestMethods.create_voluntarily.rawValue, user_account_id: userID, voluntarily_union_id: citizienSelectedUnionID, voluntarily_vehicle_status: citizienVehicleStatus, voluntarily_description: citizienDesc), type: CreateVoluntarilyPsychologistResponse.self)

        DispatchQueue.main.async {
            switch response {
            case .success(let success):
                if let status = success.status {
                    if status == "ok" {
                        self.citizienVehicleStatus = 0
                        self.citizienDesc = ""
                        self.voluntarilyPitchTent = true
                    } else {
                        self.voluntarilyPitchTent = false
                    }
                }
            case .failure(let failure):
                self.errorMessage = failure
            }
        }
    }

    func createVoluntarilyTransporter() async {
        if let vehicleCount = Int(citizienVehicleCount), let driverCount = Int(citizienDriverCount) {
            let response = await NetworkManager.shared.post(url: .voluntarilyTransporter, method: .post, model: CreateVoluntarilyTransporterRequest(method: RequestMethods.create_voluntarily.rawValue, user_account_id: userID, union_id: citizienSelectedUnionID, voluntarily_from_location: citizienFromLocation, voluntarily_to_location: citizienToLocation, voluntarily_num_of_vehicle: vehicleCount, voluntarily_num_of_driver: driverCount, voluntarily_description: citizienDesc), type: CreateVoluntarilyTransporterResponse.self)

            DispatchQueue.main.async {
                switch response {
                case .success(let success):
                    if let status = success.status {
                        if status == "ok" {
                            self.citizienVehicleCount = ""
                            self.citizienDriverCount = ""
                            self.citizienVehicleStatus = 0
                            self.citizienFromLocation = ""
                            self.citizienToLocation = ""
                            self.citizienDesc = ""
                            self.voluntarilyPsychologist = true
                        } else {
                            self.voluntarilyPsychologist = false
                        }
                    }
                case .failure(let failure):
                    self.errorMessage = failure
                }
            }
        } else {
            DispatchQueue.main.async {
                self.voluntarilyPsychologist = false
            }
        }
    }

    func readCache(userIdKey: UserCacheKeys, isUnionKey: UserCacheKeys) {
        let userID = readUserCache(key: userIdKey)
        let isUnionAccount = readUserCache(key: isUnionKey)

        DispatchQueue.main.async {
            self.userID = userID
            self.isUnionAccount = isUnionAccount
        }
    }

    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Saat, dakika ve saniye
        return dateFormatter.string(from: Date())
    }

    private func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }
}
