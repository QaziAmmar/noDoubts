//
//  AddStrengthViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 16/09/2021.
//

import Foundation
class AddStrengthViewModel: ObservableObject{
    @Published var AddStrength : addRunningModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    
    //MARK:- API
    func ApiAddStrength(duration: String, time: String, reps: String, date: String, name: String, weight: String){
        
            loading = true
        let param = ["user_id": "19",
                     "duration": duration,
                     "time": time,
                     "date": date,
                     "reps": reps,
                     "name": name,
                     "weight": weight
        ]as [String : Any]
            
            ApiManager.URLResponse("api/Workout/strength", method: .post, parameters: param, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(addRunningModel.self, from: loginData)

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
