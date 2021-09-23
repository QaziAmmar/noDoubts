//
//  InvitationCodeViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 18/09/2021.
//

import Foundation
class InvitationCodeViewModel: ObservableObject{
    @Published var InvitationCode : SignUpModels?
    @Published var loading = false
    @Published var model: BannerData?
    @Published  var moveToChangePass: Bool = false
    
    //MARK:- API
    func invitationCodeAPI(code: String , email: String){
        
            loading = true
        let parameters = ["email": email,
                          "code": code
            ]
            
            ApiManager.URLResponse("api/Users/check_code", method: .post, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SignUpModels.self, from: loginData)
                    self.loading = false
                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        self.model = BannerData(title:  loginModel.message ?? "", message: loginModel.message, color: .green, image: "success")
                        self.moveToChangePass.toggle()
                    } else {
                        //          show error
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
