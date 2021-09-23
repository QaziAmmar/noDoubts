//
//  ForgotPasswordView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 20/08/2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    // MARK:- PROPERTIES
    @State private var email = String()
    @Binding var showPass: Bool
    @ObservedObject var ForgotPass = ForgotViewModel()
    @State private var isEmailValid : Bool   = true
    
    @State private var isShowingLoader = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private var navigationLinkStacks: some View {
        
        VStack {
            NavigationLink(
                destination: InvitationLinkView(email: email, showChangeOtp: $showPass),
                isActive: $ForgotPass.movetoInvitationView,
                label: {
                    Text("")
                })
        }
    }
    
    
    var body: some View {
        loadView()
            .modifier(BannerModifier(model: $ForgotPass.model))
    }
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}


//    MARK:- View Extension
extension ForgotPasswordView {
    
    func loadView() -> some View {
        LoadingView(isShowing: $ForgotPass.loading) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .center) {
                    
                    BackButtonView()
                    
                    
                    VStack (spacing: 30) {
                        LogoData()
                        SingInTextField() //:VStack TextField
                    }
                    
                    Spacer()
                    ForgotPasswordButton()
                    navigationLinkStacks.hidden()
                    
                }.padding()
                .navigationBarHidden(true)
            }
            
            
        }
    }
    
    fileprivate func BackButtonView() -> some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack{
                    Image("back_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Forgot Password")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                }
                
            }).padding()
            .padding([.leading], -30)
            
            Divider()
            
        }
    }
    
    fileprivate func LogoData () -> some View {
        
        VStack(alignment: .center, spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
            
            Text("If you need help resetting your password we can help by sending you a link to reset it.")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 30)
        }
        .padding([.top], 30)
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
        }
    }
    
    fileprivate func ForgotPasswordButton() -> some View {
        Button(action: {
            
            is_field_are_empty()
            
        }){
            Text("Forgot Password")
            
            .font(Font.custom("Poppins-Bold", size: 16))
            .frame(minWidth : 0 , maxWidth: .infinity)
            .frame(height: 50)
                .foregroundColor(Color.white).frame(height: 60)
        }
           // .cornerRadius(6)
            //.opacity(self.password.count < 8 ? 0.7 : 1.0)
        
        .background(Color("fg"))
        .cornerRadius(10)
        .frame(height : 50)
        .padding([.top ] ,25)
    }
    
    
}

// MARK: CUTSOM FUNCTION EXTENSION
extension ForgotPasswordView {
    
    func is_field_are_empty() {
        
        // For testing purpose
        
        if  email.isEmpty  {
            ForgotPass.model = BannerData(title: "Error", message: "Please fill Email", color: .red, image: "error")
        } else {
            
            if self.isEmailValid {
                ForgotPass.sendEmailApi(email: email)
            } else {
                ForgotPass.model = BannerData(title: "Error", message: "Email formate incorrect", color: .red, image: "error")
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

