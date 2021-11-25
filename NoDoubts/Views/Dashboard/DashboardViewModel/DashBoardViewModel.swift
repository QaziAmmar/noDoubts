//
//  DashBoardViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 18/09/2021.
//

import Foundation
class DashBoardViewModel: ObservableObject{
    @Published var Dash : DashboardModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published var isCalledApi: Bool = true
    @Published var isUpdate: Bool = false
    
    
    func loadJson(from decoder: Decoder ) throws {
        
        Dash = try DashboardModel(from: decoder)
    }
    
    //MARK:- getDashBoard Data Api
    func ApiDashBoard(){
        isCalledApi = false
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
        
            ApiManager.URLResponse("api/Users/dashboard?user_id=\(userId)", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(DashboardModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.isUpdate = true
                        self.Dash = competitionsModels
//                  r
                    } else {
                        //                    show error

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

