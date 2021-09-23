//
//  EditProfileViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import Foundation
import Alamofire
class EditProfileViewModel: ObservableObject {
    @Published var editProfile : SignUpModels?
    @Published var loading = false
    @Published var model: BannerData?
   // @Published  var movetoDashboard: Bool = false
    
    //MARK:- API
    func editProfileApi(name: String , image: String, password: String, email: String, gender: String, fitnessLvl: String){
        
            loading = true
        let parameters: Parameters = ["id": "19",
                              "name": name,
                              "password": password,
                              "image": image,
                              "email": email,
                              "gender": gender,
                              "fitness_level": fitnessLvl
            ]
            
            ApiManager.URLResponse("api/Users/user", method: .put, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SignUpModels.self, from: loginData)
                    self.loading = false
                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                    } else {
                        //                    show error
                        self.loading = false
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
