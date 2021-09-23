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
    //@Published  var movetoDashboard: Bool = false
    
    func loadJson(from decoder: Decoder ) throws {
        
        Dash = try DashboardModel(from: decoder)
    }
    
    //MARK:- getDashBoard Data Api
    func ApiDashBoard(){
        
            loading = true
            
            ApiManager.URLResponse("api/Users/dashboard?user_id=20", method: .get, parameters: nil, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(DashboardModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.Dash = competitionsModels
//                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
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

