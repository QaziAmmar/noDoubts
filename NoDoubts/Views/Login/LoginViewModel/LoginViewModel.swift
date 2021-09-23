//
//  LoginViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
class LoginViewModel: ObservableObject{
    @Published var Login : LoginModel?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    //MARK:- SignUp Api
    func ApiCalling(email: String , password: String){
        
            loading = true
            let parameters = ["email": email,
                              "password": password
            ] as [String : Any]
            
            ApiManager.URLResponse("api/Users/login", method: .post, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SignUpModels.self, from: loginData)

                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        AppHelper.helper.saveMyUser(loginModel)
//                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                        self.movetoDashboard.toggle()
                        //showHomeView.toggle()
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
