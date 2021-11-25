//
//  RunningViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 13/09/2021.
//

import Foundation
class RunningViewModel: ObservableObject{
    @Published var Running : RunnigModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    
    func loadJson(from decoder: Decoder ) throws {
        
        Running = try RunnigModel(from: decoder)
    }
    
    //MARK:- SignUp Api
    func ApiCalling(
    ){
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
            
            ApiManager.URLResponse("api/Workout/running?user_id=\(userId)", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(RunnigModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.Running = competitionsModels
//                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
                        self.loading = false
                        //                    show error
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

