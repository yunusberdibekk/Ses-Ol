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
    
    @Published var unionPosts: UnionPostResponse? = nil
    @Published var unions: UnionResponse? = nil
    @Published var supportCategories: SupportCategoriesResponse? = nil
    @Published var disasters: DisasterResponse? = nil

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

    private let networkManager = NetworkManager(config: NetworkConfig(baseUrl: NetworkPath.baseURL))
    private let cache = UserDefaultCache()

    func getUnionPosts() async {
        let posts = await getAllUnionPosts(method: .read_post)

        if let posts = posts {
            DispatchQueue.main.async {
                self.unionPosts = self.parseUnionPost(response: posts)
            }
        }
    }

    func parseUnionPost(response: UnionPostResponse) -> UnionPostResponse {
        var postlar = UnionPostResponse()

        for post in response {
            if post.publisherUnionID == self.userID {
                postlar.append(post)
            }
        }
        return postlar
    }

    func readCitizienProfile() async {
        let response = await readUserProfileID(method: .read_user, user_account_id: userID)
        DispatchQueue.main.async {
            self.adressId = response
        }
    }

    func getUnions() async {
        let response = await getAllUnions(method: .get_all_unions)

        DispatchQueue.main.async {
            self.unions = response
        }
    }

    func getSupportCategories() async {
        let response = await getAllSupportCategories()

        DispatchQueue.main.async {
            self.supportCategories = response
        }
    }

    func getDisasters() async {
        let response = await getAllDisasters()

        DispatchQueue.main.async {
            self.disasters = response
        }
    }

    func createHelpRequest() async {
        let response = await createHelpRequest(method: .create_request, request_account_id: userID, num_of_person: citizienNumOfPerson, request_disaster_id: citizienSelectedDisasterID, request_union_id: citizienSelectedUnionID, request_category: selectedCategoryID, request_desc: citizienDesc)

        if response == "ok" {
            DispatchQueue.main.async {
                self.createHelpRequest = true
            }
            DispatchQueue.main.async {
                self.citizienNumOfPerson = 0
            }
            DispatchQueue.main.async {
                self.citizienDesc = ""
            }
        } else {
            DispatchQueue.main.async {
                self.createHelpRequest = false
            }
        }

    }

    func createProvidingAssistance() async {
        let response = await createProvidingAssistance(method: .create_assistance, user_assistance_account_id: userID, assistance_title: citizienTittle, assistance_sent_union_id: citizienSelectedUnionID, assistance_num_of_person: citizienNumOfPerson, assistance_category_id: selectedCategoryID, assistance_desc: citizienDesc, assistance_address_id: adressId, is_a_union: isUnionAccount)

        if response == "ok" {
            DispatchQueue.main.async {
                self.createSupportRequest = true
            }
            DispatchQueue.main.async {
                self.citizienNumOfPerson = 0
            }
            DispatchQueue.main.async {
                self.citizienDesc = ""
            }
        } else {
            DispatchQueue.main.async {
                self.createSupportRequest = false
            }
        }
    }

    func createPost() async {
        let response = await createPost(method: .create_post, post_publisher_id: userID, post_content: unionPostDesc)

        if response == "ok" {
            DispatchQueue.main.async {
                self.createPost = true
            }
        } else {
            DispatchQueue.main.async {
                self.createPost = false
            }
        }
    }

    func createVoluntarilyPsychologist() async {
        let response = await createVoluntarilyPsychologist(method: .create_voluntarily, user_account_id: userID, voluntarily_union_id: citizienSelectedUnionID, voluntarily_vehicle_status: citizienVehicleStatus, voluntarily_desc: citizienDesc)

        if response == "ok" {
            DispatchQueue.main.async {
                self.citizienVehicleStatus = 0
            }

            DispatchQueue.main.async {
                self.citizienDesc = ""
            }

            DispatchQueue.main.async {
                self.voluntarilyPsychologist = true
            }
        } else {
            DispatchQueue.main.async {
                self.voluntarilyPsychologist = false
            }
        }
    }

    func createVoluntarilyPitchTent() async {
        let response = await createVoluntarilyPitchTent(method: .create_voluntarily, user_account_id: userID, voluntarily_union_id: citizienSelectedUnionID, voluntarily_vehicle_status: citizienVehicleStatus, voluntarily_desc: citizienDesc)

        if response == "ok" {
            DispatchQueue.main.async {
                self.citizienVehicleStatus = 0
            }

            DispatchQueue.main.async {
                self.citizienDesc = ""
            }

            DispatchQueue.main.async {
                self.voluntarilyPitchTent = true
            }
        } else {
            DispatchQueue.main.async {
                self.voluntarilyPitchTent = false
            }
        }
    }

    func createVoluntarilyTransporter() async {
        if let vehicleCount = Int(citizienVehicleCount), let driverCount = Int(citizienDriverCount) {
            let response = await createVoluntarilyTransporter(method: .create_voluntarily, user_account_id: userID, union_id: citizienSelectedUnionID, voluntarily_from_location: citizienFromLocation, voluntarily_to_location: citizienToLocation, voluntarily_num_of_vehicle: vehicleCount, voluntarily_num_of_driver: driverCount, voluntarily_desc: citizienDesc)

            if response == "ok" {
                DispatchQueue.main.async {
                    self.citizienVehicleCount = ""
                }
                DispatchQueue.main.async {
                    self.citizienDriverCount = ""
                }
                DispatchQueue.main.async {
                    self.citizienVehicleStatus = 0
                }
                DispatchQueue.main.async {
                    self.citizienFromLocation = ""
                }
                DispatchQueue.main.async {
                    self.citizienToLocation = ""
                }
                DispatchQueue.main.async {
                    self.citizienDesc = ""
                }
                DispatchQueue.main.async {
                    self.voluntarilyPsychologist = true
                }
            } else {
                DispatchQueue.main.async {
                    self.voluntarilyPsychologist = false
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
}

extension PostViewModel: IPostViewModel {
    func readUserProfileID(method: RequestMethods, user_account_id: Int) async -> Int {
        let response = await networkManager.post(path: .usersCrud, model: CitizienProfileRequest(method: method.rawValue, user_account_id: user_account_id), type: CitizienProfileResponse.self)
        return response?.addressID ?? -1
    }

    func getAllUnionPosts(method: RequestMethods) async -> UnionPostResponse? {
        guard let response = await networkManager.post(path: .unionPostCrud, model: UnionPostRequest(method: method.rawValue), type: UnionPostResponse.self) else { return nil }
        return response
    }

    func createVoluntarilyPsychologist(method: RequestMethods, user_account_id: Int, voluntarily_union_id: Int, voluntarily_vehicle_status: Int, voluntarily_desc: String) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyPsychologist, model: CreateVoluntarilyPsychologistRequest(method: method.rawValue, user_account_id: user_account_id, voluntarily_union_id: voluntarily_union_id, voluntarily_vehicle_status: voluntarily_vehicle_status, voluntarily_desc: voluntarily_desc), type: CreateVoluntarilyPsychologistResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func createVoluntarilyPitchTent(method: RequestMethods, user_account_id: Int, voluntarily_union_id: Int, voluntarily_vehicle_status: Int, voluntarily_desc: String) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyPitchTent, model: CreateVoluntarilyPitchTentRequest(method: method.rawValue, user_account_id: user_account_id, voluntarily_union_id: voluntarily_union_id, voluntarily_vehicle_status: voluntarily_vehicle_status, voluntarily_description: voluntarily_desc), type: CreateVoluntarilyPsychologistResponse.self) else { return "error" }
        return response.status ?? "error" }

    func createVoluntarilyTransporter(method: RequestMethods, user_account_id: Int, union_id: Int, voluntarily_from_location: String, voluntarily_to_location: String, voluntarily_num_of_vehicle: Int, voluntarily_num_of_driver: Int, voluntarily_desc: String) async -> String {
        guard let response = await networkManager.post(path: .voluntarilyTransporter, model: CreateVoluntarilyTransporterRequest(method: method.rawValue, user_account_id: user_account_id, union_id: union_id, voluntarily_from_location: voluntarily_from_location, voluntarily_to_location: voluntarily_to_location, voluntarily_num_of_vehicle: voluntarily_num_of_vehicle, voluntarily_num_of_driver: voluntarily_num_of_driver, voluntarily_description: voluntarily_desc), type: CreateVoluntarilyTransporterResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func createPost(method: RequestMethods, post_publisher_id: Int, post_content: String) async -> String {
        guard let response = await networkManager.post(path: .unionPostCrud, model: CreatePostRequest(method: method.rawValue, post_publisher_id: post_publisher_id, post_content: post_content), type: CreatePostResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func createProvidingAssistance(method: RequestMethods, user_assistance_account_id: Int, assistance_title: String, assistance_sent_union_id: Int, assistance_num_of_person: Int, assistance_category_id: Int, assistance_desc: String, assistance_address_id: Int, is_a_union: Int) async -> String {
        guard let response = await networkManager.post(path: .providingAssistanceCrud, model: CreateSupportRequest(method: method.rawValue, user_assistance_account_id: user_assistance_account_id, assistance_title: assistance_title, assistance_sent_union_id: assistance_sent_union_id, assistance_num_of_person: assistance_num_of_person, assistance_category_id: assistance_category_id, assistance_desc: assistance_desc, assistance_address_id: assistance_address_id, is_a_union: is_a_union), type: CreateSupportRequestResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func createHelpRequest(method: RequestMethods, request_account_id: Int, num_of_person: Int, request_disaster_id: Int, request_union_id: Int, request_category: Int, request_desc: String) async -> String {
        guard let response = await networkManager.post(path: .requestCrud, model: CreateUserRequest(method: method.rawValue, request_account_id: request_account_id, num_of_person: num_of_person, request_disaster_id: request_disaster_id, request_union_id: request_union_id, request_category: request_category, request_desc: request_desc), type: CreateUserHelpRequestResponse.self) else { return "error" }
        return response.status ?? "error"
    }

    func getAllUnions(method: RequestMethods) async -> UnionResponse? {
        guard let response = await networkManager.post(path: .unionsCrud, model: UnionRequest(method: method.rawValue), type: UnionResponse.self) else { return nil }
        return response
    }

    func getAllSupportCategories() async -> SupportCategoriesResponse? {
        guard let response = await networkManager.fetch(path: .getRequirement, method: .get, type: SupportCategoriesResponse.self) else { return nil }
        return response
    }

    func getAllDisasters() async -> DisasterResponse? {
        guard let response = await networkManager.fetch(path: .getDisaster, method: .get, type: DisasterResponse.self) else { return nil }
        return response
    }

    func readUserCache(key: UserCacheKeys) -> Int {
        let response = cache.read(key: key)
        guard let responseInt = Int(response) else { return -1 }
        return responseInt
    }

}

protocol IPostViewModel {
    func createHelpRequest(method: RequestMethods, request_account_id: Int, num_of_person: Int, request_disaster_id: Int, request_union_id: Int, request_category: Int, request_desc: String) async -> String

    func createProvidingAssistance(method: RequestMethods, user_assistance_account_id: Int, assistance_title: String, assistance_sent_union_id: Int, assistance_num_of_person: Int, assistance_category_id: Int, assistance_desc: String, assistance_address_id: Int, is_a_union: Int) async -> String

    func createVoluntarilyPsychologist(method: RequestMethods, user_account_id: Int, voluntarily_union_id: Int, voluntarily_vehicle_status: Int, voluntarily_desc: String) async -> String

    func createVoluntarilyPitchTent(method: RequestMethods, user_account_id: Int, voluntarily_union_id: Int, voluntarily_vehicle_status: Int, voluntarily_desc: String) async -> String

    func createVoluntarilyTransporter(method: RequestMethods, user_account_id: Int, union_id: Int, voluntarily_from_location: String, voluntarily_to_location: String, voluntarily_num_of_vehicle: Int, voluntarily_num_of_driver: Int, voluntarily_desc: String) async -> String

    func createPost(method: RequestMethods, post_publisher_id: Int, post_content: String) async -> String
    func readUserProfileID(method: RequestMethods, user_account_id: Int) async -> Int
    func getAllUnionPosts(method: RequestMethods) async -> UnionPostResponse?
    func getAllUnions(method: RequestMethods) async -> UnionResponse?
    func getAllSupportCategories() async -> SupportCategoriesResponse?
    func getAllDisasters() async -> DisasterResponse?
    func readUserCache(key: UserCacheKeys) -> Int

}
