//
//  InvitationLinkView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 20/08/2021.
//

import SwiftUI


struct InvitationLinkView: View {
    
    // MARK:- PROPERTIES
    
    var email : String
    @Binding var showChangeOtp: Bool
    @ObservedObject var InvitationCode = InvitationCodeViewModel()
    @State private var isEmailValid : Bool   = true
    @State private var movetoInvitationView: Bool = false
    @State private var isShowingLoader = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private var navigationLinkStacks: some View {
        
        VStack {
            NavigationLink(
                destination: VarificationVIew(value: $showChangeOtp),
                isActive: $InvitationCode.moveToChangePass,
                label: {
                    Text("")
                })
        }
    }
    
    
    var body: some View {
        loadView()
            .modifier(BannerModifier(model: $InvitationCode.model))
    }
}

//struct InvitationLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        InvitationLinkView(email: <#String#>)
//    }
//}
//    MARK:- View Extension
extension InvitationLinkView {
    
    func loadView() -> some View {
        LoadingView(isShowing: $InvitationCode.loading) {
            
            HStack(alignment: .top) {
                
                VStack(alignment: .center) {
                    
                    BackButtonView()
                    
                    
                    VStack (spacing: 5) {
                        LogoData()
                        subtitleView()
                        ///SingInTextField() //:VStack TextField
                    }
                    OTPTextFieldView { otp, completionHandler in

                        InvitationCode.invitationCodeAPI(code: otp, email: email)

                    }.padding(.top , 25)
                    
                    Spacer()
                    //ForgotPasswordButton()
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
            
            Text("Email Verification")
                .font(.custom("Poppins-Bold", size: 26))
                .foregroundColor(Color("EmailColor"))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 30)
        }
        .padding([.top], 30)
    }
    
    fileprivate func ForgotPasswordButton() -> some View {
        Button(action: {
            
            is_field_are_empty()
            
        }, label: {
            Text("Forgot Password")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(10)
            
            
        })
        .frame( height: 50)
        .padding([.top], 25)
    }
    //MARK:- Subtitle
    private func subtitleView() -> some View {
        VStack{
            Text("Please enter the 4-digit code send to you at").frame(minWidth : 0 , maxWidth: .infinity ,alignment: .center).font(Font.custom("Poppins-Bold", size: 12)).foregroundColor(Color("SubtitleColor")).padding(.leading , 25).padding(.trailing , 25)
            Text(email).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .center).font(Font.custom("Poppins-Bold", size: 12)).padding(.leading , 25).padding(.trailing , 25).padding(.top , 1)
          
           
            
        }
    }
    
    
}

// MARK: CUTSOM FUNCTION EXTENSION
extension InvitationLinkView {
    
    func is_field_are_empty() {
        
        // For testing purpose
        
        if  email.isEmpty  {
            InvitationCode.model = BannerData(title: "Error", message: "Please fill Email", color: .red, image: "error")
        } else {
            
            if self.isEmailValid {
                //move to next screen
                print("move to next screen")
            } else {
                InvitationCode.model = BannerData(title: "Error", message: "Email formate incorrect", color: .red, image: "error")
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
