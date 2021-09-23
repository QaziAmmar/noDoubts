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
    @State private var movetoSingUpLink: Bool = false
    @State private var movetoForgotPassworView: Bool = false
    @State var isShowingLoader = false
   
    @ObservedObject var Login = LoginViewModel()
    private var navigationLinksStacks: some View {
        
        VStack {
            NavigationLink(
                destination: SignUpView(),
                isActive: $movetoSingUpLink,
                label: {
                    Text("")
                })
            
            NavigationLink(
                destination: DashboardView(),
                isActive: $Login.movetoDashboard,
                label: {
                    Text("")
                })
            
            NavigationLink(
                destination: ForgotPasswordView(showPass: $movetoForgotPassworView),
                isActive: $movetoForgotPassworView,
                label: {
                    Text("")
                })
        }
    }
    
    var body: some View {
        loadView()
            .modifier(BannerModifier(model: $Login.model))
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
        LoadingView(isShowing: $Login.loading) {
            NavigationView {
                VStack(alignment: .center) {
                    
                    VStack (spacing: 30) {
                        LogoData()
                        SingInTextField() //:VStack TextField
                    }
                    SignInButton()
                    OR_Divider()
                    GmailButton() //ZStack: Gmail Button
                    ForgotPassword() //VStack: Forgot Password
                    navigationLinksStacks.hidden()
                    
                }.padding()
                .navigationBarHidden(true)
                
            }
        }
    }
    
    fileprivate func LogoData () -> some View {
        
        VStack(spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
            VStack(spacing: 5) {
                Text("Welcome to NODOUBTS")
                    .font(.custom("Poppins-Bold", size: 16))
                
                Text("Sign in to continue")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color.gray)
            }
            
        }
    }
    
    fileprivate func SingInTextField() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("Message")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        TextField("Your Email", text: $email)
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
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        Image("Password")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding([.leading], 20)
                        
                        TextField("Password", text: $password)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Password
            }
    }
    
    fileprivate func SignInButton() -> some View {
         Button(action: {
            
            if is_field_are_empty{
                Login.ApiCalling(email: email, password: password)
               
            }
            
        }, label: {
            Text("Sign In")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(10)
            
            
        })
         .frame( height: 50)
         .padding([.top], 25)
    }
    
    fileprivate func OR_Divider () -> some View {
        HStack {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("light"))
            
            Text("OR")
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(Color("light"))
                .padding([.leading, .trailing])
            
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color("light"))
        } //: HStack OR with Line
        .padding([.top], 23)
    }
    
    fileprivate func GmailButton() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color("light"), lineWidth: 0.2)
                )
            
            HStack {
                
                Button(action: {
                    print("google button")
                }, label: {
                    HStack{
                        Image("Google")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Spacer()
                        Text("Login with Google")
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(Color("light"))
                            .padding([.leading], -30)
                        
                        Spacer()
                        
                    }
                }).padding()
                
                
            } //HStack: Gmail Login
            
            
        }
    }
    
    fileprivate func ForgotPassword() -> some View {
        VStack(spacing: 8) {
            
            Button(action: {
                movetoForgotPassworView.toggle()
            }, label: {
                Text("Forgot Password?")
                    .font(.custom("Poppins-Bold", size: 15))
                    .foregroundColor(Color("fg"))
            })
            .padding([.leading, .top, .trailing]) // Forgot Password Button
            
            HStack {
                Text("Don’t have a account?")
                    .font(.custom("Poppins-Regular", size: 13))
                    .foregroundColor(Color("light"))
                    .padding([.trailing], -15)
                
                Button(action: {
                    print("register button")
                    movetoSingUpLink.toggle()
                }, label: {
                    Text("Register")
                        .font(.custom("Poppins-Bold", size: 13))
                        .foregroundColor(Color("fg"))
                }).padding() //: Register Button
                
            }
        }.padding([.top], 25)
    }
    
}

// MARK: CUTSOM FUNCTION EXTENSION
extension LoginView {
    
    var is_field_are_empty:  Bool {
        
        // For testing purpose
       //
        
        if  email.isEmpty || password.isEmpty  {
            Login.model = BannerData(title: "Error", message: "Please fill all the fields", color: .red, image: "error")
            return false
        } else {
            //      If all fields are filled then check the check the email and password fields
            if self.isEmailValid {
                //                if email is valid then check that both passwords filed are same
                if is_password_length_satisfied() {
                    return true
                }
              
                
            } else {
                //                if email formate is not valid.
                Login.model = BannerData(title: "Error", message: "Email formate incorrect", color: .red, image: "error")
                return false
            }
            
        }
        return false
    }
        
        func is_password_length_satisfied() -> Bool {
            //        This function check either both text fileds are empty of filled
            //                now check the lenght is greater then 6 or not
            if password.count > 5 {
                return true
            } else {
                Login.model = BannerData(title: "Error", message: "Please enter atleast 6 character", color: .red, image: "error")
                return false
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
