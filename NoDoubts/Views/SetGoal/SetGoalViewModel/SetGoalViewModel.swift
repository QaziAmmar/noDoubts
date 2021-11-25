//
//  SetGoalViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
import SwiftUI
class SetGoalViewModel : ObservableObject{
    @Published var SetGoal : SetGoalViewModel?
    @Published var loading = false
    @Binding var showGoal: Bool
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    init(showGoal: Binding<Bool>) {
        _showGoal = showGoal
    }
    
    //MARK:- API
    func setGoalApi(name: String , description: String){
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else{
            return
        }
        let userId = profile.data?.id ?? ""
            let parameters = ["user_id": userId,
                              "name": name,
                              "description": description
            ] as [String : Any]
            
            ApiManager.URLResponse("api/Workout/goal", method: .post, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SetGoalModel.self, from: loginData)

                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                        self.showGoal.toggle()
                    } else {
                        //                    show error
                        self.model = BannerData(title: loginModel.message ?? "", message: loginModel.message, color: .red, image: "error")
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
