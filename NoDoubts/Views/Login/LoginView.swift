//
//  LoginView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 17/08/2021.
//

import SwiftUI

struct LoginView: View {
    
    // MARK:- PROPERTIES
    @State private var email = String()
    @State private var password = String()
    @State private var secured: Bool = true
    @State private var isEmailValid : Bool   = true
    
    
    @State private var isShowingLoader = false
    @State var model: BannerData?
    
    var body: some View {
        loadView()
            .modifier(BannerModifier(model: $model))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


//    MARK:- View Extension
extension LoginView {
    func loadView() -> some View {
        LoadingView(isShowing: $isShowingLoader) {
            VStack {
                
                
                ZStack(alignment: .leading) {
        
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: .infinity, height: 50)
                        .overlay(
                               RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                           )
                        
                        
                    
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding([.leading], 20)
                        
                        TextField("Enter your email address", text: $email)
                            .onChange(of: email, perform: { value in
                                //                        check is email formate is valid.
                                if self.textFieldValidatorEmail(value) {
                                    self.isEmailValid = true
                                } else {
                                    self.isEmailValid = false
                                }
                            })

                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                    }
            
                    
                    
                } // :ZStack Email
                
                VStack(alignment: .leading) {
                    
                    TextField("Enter your email address", text: $email)
                        .onChange(of: email, perform: { value in
                            //                        check is email formate is valid.
                            if self.textFieldValidatorEmail(value) {
                                self.isEmailValid = true
                            } else {
                                self.isEmailValid = false
                            }
                        })
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(8)
                        .font(.custom("OpenSans-Regular", size: 16))
                    
                } // :VStack Email
                
            }.padding()
        }
    }
}

// MARK: CUTSOM FUNCTION EXTENSION
extension LoginView {
    
    func is_field_are_empty() {
        
        if  email.isEmpty || password.isEmpty  {
            model = BannerData(title: "Error", message: "Please fill all the fields", color: .red, image: "error")
        } else {
            //      If all fields are filled then check the check the email and password fields
            if self.isEmailValid {
                //                if email is valid then check that both passwords filed are same
                if is_password_length_satisfied() {
                    //                 call SignUp Api
                    //                    callLoginApi()
                }
                
            } else {
                //                if email formate is not valid.
                model = BannerData(title: "Error", message: "Email formate incorrect", color: .red, image: "error")
            }
            
        }
        
        func is_password_length_satisfied() -> Bool {
            //        This function check either both text fileds are empty of filled
            //                now check the lenght is greater then 6 or not
            if password.count > 5 {
                return true
            } else {
                model = BannerData(title: "Error", message: "Please enter atleast 6 character", color: .red, image: "error")
                return false
            }
        }
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        //        Email validator
        
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}
