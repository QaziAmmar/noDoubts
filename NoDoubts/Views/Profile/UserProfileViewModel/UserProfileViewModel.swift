//
//  UserProfileViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 21/09/2021.
//

import Foundation
class UserProfileViewModel: ObservableObject{
    @Published var UserProfile : UserProfileModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    func loadJson(from decoder: Decoder ) throws {
        
        UserProfile = try UserProfileModel(from: decoder)
    }
    //MARK:- Strength  Api
    
    func ApiUserProfile(){
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
            
            ApiManager.URLResponse("api/Users/user?id=\(userId)", method: .get, parameters: nil, headers: nil) { competitions in
                do {
                    let decoder = JSONDecoder()
                    let userProfileModel = try decoder.decode(UserProfileModel.self, from: competitions)

                    if userProfileModel.status == 1 {
                        self.loading = false
                        print(userProfileModel)
                        self.UserProfile = userProfileModel
                    } else {
                        self.model = BannerData(title: userProfileModel.message ?? "", message: userProfileModel.message, color: .red, image: "error")
                    }
                } catch let error {
                    self.loading = false
                    print(error)
                }
                
                
            } withapiFiluer: { error in
                self.loading = false
                print("\(error)")
            }
    }
}
