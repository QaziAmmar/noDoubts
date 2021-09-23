//
//  VarificationVIew.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 20/08/2021.
//

import SwiftUI

struct VarificationVIew: View {
    @Binding var showHome: Bool
    @ObservedObject var changePassword : NewPsswordViewModel
    @State private var email : String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(value: Binding<Bool>){
        _showHome = value
        _changePassword = ObservedObject(wrappedValue: NewPsswordViewModel(showHomePa: value))
        }
    var body: some View {
        LoadingView(isShowing: $changePassword.loading) {
        VStack{
            BackButtonView()
            LogoData()
            PasswordTextField()
            ForgotPasswordButton().padding(.top , 30)
            Spacer()
            
        }.modifier(BannerModifier(model: $changePassword.model))
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
                    Text("Change Password")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                }
                
            }).padding()
            .padding([.leading], -10)
            
            Divider()
            
        }
    }
    fileprivate func LogoData () -> some View {
        
        VStack(alignment: .center, spacing: 20) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72, alignment: .center)
            
            Text("Create new password")
                .font(.custom("Poppins-Bold", size: 26))
                .foregroundColor(Color("EmailColor"))
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 30)
        }
        .padding([.top], 30)
    }
    //MARK:- Name Text Field
    
    private func PasswordTextField() -> some View {
        VStack(spacing: 0){
            HStack(spacing: 18) {
                Image("LockImage").resizable().scaledToFit().frame( width : 20, height: 20).foregroundColor(.gray)
          TextField("Password", text: $email).font(Font.system(size: 13 , weight: .regular))
          
        }.padding().padding(.leading , 10)
            Divider().padding(.leading , 25).padding(.trailing , 25)
        }.padding(.top , 24)
}
    fileprivate func ForgotPasswordButton() -> some View {
        Button(action: {
            if email.isEmpty{
                changePassword.model = BannerData(title: "Error", message: "Please fill Email", color: .red, image: "error")
                return
            }else{
                changePassword.changePasswordAPI(password: email)
            }
          
            
        }) {
            Text("Change Password")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .frame(height: 50)
                    .foregroundColor(Color.white).frame(height: 60)
            
            
        }.background(Color("fg"))
        .cornerRadius(10)
        .frame(height : 50)
        .padding()
    }
}

//struct VarificationVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        VarificationVIew()
//    }
//}
