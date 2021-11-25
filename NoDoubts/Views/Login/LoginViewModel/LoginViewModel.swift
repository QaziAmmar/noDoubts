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
    @Published var myGoogle = GoogleStuff()
    @Published var model: BannerData?
    @Published  var movetoDashboard: Bool = false
    //MARK:- SignUp Api
    func ApiCalling(email: String , password: String){
        
            loading = true
            let parameters = ["email": email,
                              "password": password
            ] as [String : Any]
        UserDefaults.standard.setValue(password, forKey: "UserPassword")
            
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
                        self.loading = false
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
    //MARK:- Social Login
    func APISocialLogin(social_key : String , email : String , name : String , social_token : String){
       
        
       self.loading = true
           //facebook,google,apple
           
           let param = ["social_key":social_key,
                        "email":email,
                        "name":name,
                        "social_token": social_token]
           
        ApiManager.URLResponse("api/Users/signUpSocial", method: .post, parameters: param, headers: nil){ loginData in
           //            parse login data
           do {
               let decoder = JSONDecoder()
               let loginModel = try decoder.decode(SignUpModels.self, from: loginData)
               self.loading = true
               //        End Progress View
               
               if loginModel.status == 1 {
                   self.loading = false
                   AppHelper.helper.saveMyUser(loginModel)
                   print(loginModel)
                self.movetoDashboard.toggle()
             
                  
                   //                    move to next screen
                self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                UserDefaults.standard.removeObject(forKey: "UserPassword")
               } else {
                self.loading = false
                   //                    show error
                self.model = BannerData(title: loginModel.message ?? "", message: loginModel.message, color: .red, image: "error")
                
               }
           } catch let error {
            self.loading = false
               //        End Progress View
               print(error)
           }
           
           
       } withapiFiluer: { error in
        self.loading = false
           print("\(error)")
           //        Start Progress View
       }
   
   }

}
