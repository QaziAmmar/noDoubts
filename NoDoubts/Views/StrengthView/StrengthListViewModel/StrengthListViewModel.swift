//
//  StrengthListViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 16/09/2021.
//

import Foundation
class StrengthViewModel: ObservableObject{
    @Published var StrengthList : StrengthModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    
    func loadJson(from decoder: Decoder ) throws {
        
        StrengthList = try StrengthModel(from: decoder)
    }
    //MARK:- Strength  Api
    func ApiStrengthList(){
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
            
            ApiManager.URLResponse("api/Workout/strength?user_id=\(userId)", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(StrengthModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.StrengthList = competitionsModels
//                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
                        self.loading = false
//                        self.model = BannerData(title: competitionsModels.message ?? "", message: competitionsModels.message, color: .red, image: "error")
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
