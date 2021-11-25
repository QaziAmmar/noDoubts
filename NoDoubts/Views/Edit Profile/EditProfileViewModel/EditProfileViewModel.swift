//
//  EditProfileViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import Foundation
import Alamofire
import SwiftUI
class EditProfileViewModel: ObservableObject {
    @Published var editProfile : SignUpModels?
    @Published var loading = false
    @Published var ButtonDisable = false
    @Published var model: BannerData?
    @Published var changeProfile: String?
//    var email: String = ""
//     var Name: String = ""
//     var Gender: String = ""
//     var ProfileiMage: String = ""
//     var fitnessLevel: String = ""
//     var age: String = ""
//    init(emailValue: Binding<String>, fitnes: Binding<String>, nameValue: Binding<String>, age: Binding<String>, profilePic: Binding<String>, gender: Binding<String>) {
//        _email = emailValue
//        _age = age
//        _Gender = gender
//        _ProfileiMage = profilePic
//        _Name = nameValue
//        _fitnessLevel = fitnes
//
//    }
   // @Published  var movetoDashboard: Bool = false
    
    //MARK:- API
    func editProfileApi(name: String , password: String, email: String, gender: String, fitnessLvl: String){
        
            loading = true
        guard let profile = AppHelper.helper.loadMyUser() else{
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
        let parameters: Parameters = ["id": userId,
                              "name": name,
                              "password": password,
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
//                        print(loginModel)
                        AppHelper.helper.saveMyUser(loginModel)
                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                        self.changeProfile = loginModel.data?.image ?? ""
                        
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
    //MARK:- API Update ProfileImage
    func editProfileImageAPI(image: String){
        
            loading = true
        ButtonDisable = true
        guard let profile = AppHelper.helper.loadMyUser() else{
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
        let parameters: Parameters = ["user_id": userId,
                              "image": image
                             
            ]
            
            ApiManager.URLResponse("api/Users/userImage", method: .put, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SignUpModels.self, from: loginData)
                    self.loading = false
                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        AppHelper.helper.saveMyUser(loginModel)
                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                        self.changeProfile = loginModel.data?.image ?? ""
                        self.ButtonDisable = false
                    } else {
                        //                    show error
                        self.loading = false
                        self.ButtonDisable = false
                        self.model = BannerData(title: loginModel.message ?? "", message: loginModel.message, color: .red, image: "error")
                    }
                } catch let error {
                    self.ButtonDisable = false
                    self.loading = false
                    print(error)
                }
                
                
            } withapiFiluer: { error in
                self.ButtonDisable = false
                self.loading = false
                print("\(error)")
            }
    }

}
