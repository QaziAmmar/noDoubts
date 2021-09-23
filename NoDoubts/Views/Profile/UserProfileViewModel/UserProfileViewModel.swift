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
            
            ApiManager.URLResponse("api/Users/user?id=20", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let userProfileModel = try decoder.decode(UserProfileModel.self, from: competitions)

                    if userProfileModel.status == 1 {
                        self.loading = false
                        print(userProfileModel)
                        self.UserProfile = userProfileModel
//                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
                        //                    show error
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
