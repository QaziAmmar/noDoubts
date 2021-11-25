//
//  AddRunningViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import Foundation
import SwiftUI
class AddRunningViewModel: ObservableObject {
    @Published var addRunng : addRunningModel?
    @Published var loading = false
    @Binding var showAddRunning: Bool
    @Published var model: BannerData?
    init(showHomePa: Binding<Bool>) {
        _showAddRunning = showHomePa
    }
    
    
    //MARK:- AddRunning Api
    func addRunningApi(distance: String, time: String, average_speed: String, date: String){
        
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
        let param = ["user_id": userId,
                     "distance": distance,
                     "time": time,
                     "date": date,
                     "average_speed": average_speed
        ]as [String : Any]
            
            ApiManager.URLResponse("api/Workout/running", method: .post, parameters: param, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(addRunningModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.loading = false
                        print(competitionsModels)
                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                        self.showAddRunning.toggle()
                    } else {
                        self.loading = false
                        self.model = BannerData(title: competitionsModels.message ?? "", message: competitionsModels.message, color: .red, image: "error")
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
