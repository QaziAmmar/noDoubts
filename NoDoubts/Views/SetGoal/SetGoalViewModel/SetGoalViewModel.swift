//
//  SetGoalViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
class SetGoalViewModel : ObservableObject{
    @Published var SetGoal : SetGoalViewModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    
    //MARK:- API
    func setGoalApi(name: String , description: String){
        
            loading = true
            let parameters = ["user_id": "19",
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
