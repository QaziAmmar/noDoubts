//
//  NewPasswordViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 20/09/2021.
//

import Foundation
import SwiftUI
class NewPsswordViewModel: ObservableObject{
    @Published var loading = false
     @Binding var showHome: Bool
    @Published var model: BannerData?
    @Published  var movetoInvitationView: Bool = false
    init(showHomePa: Binding<Bool>) {
        _showHome = showHomePa
    }
   // @Published  var movetoDashboard: Bool = false
    
    //MARK:- API
    func changePasswordAPI(password: String){
        
            loading = true
        let parameters = ["user_id": "20",
                          "password": password
            ]
            
            ApiManager.URLResponse("api/Users/change_password", method: .put, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SignUpModels.self, from: loginData)
                    self.loading = false
                    if loginModel.status == 1 {
                        self.loading = false
                        print(loginModel)
                        self.showHome.toggle()
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


