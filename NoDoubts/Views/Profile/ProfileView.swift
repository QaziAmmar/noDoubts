//
//  ProfileView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @State private var gender = String()
    @ObservedObject var userprofile = UserProfileViewModel()
      @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPressEditButton = false
    var body: some View {
        loadView()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
//    MARK:- View Extension
extension ProfileView {
    func loadView() -> some View {
        LoadingView(isShowing: $userprofile.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            ProfileImage()
            UserProfileData()
            ConnectToWatchButton()
            LogoutButton()
            goToEditProfile
            Spacer()
           
        }.padding().onAppear(){
            userprofile.ApiUserProfile()
        }.navigationBarHidden(true)
        }
        
    }
    //MARK:- Back Button
    fileprivate func BackButtonView() -> some View {
        
        VStack(alignment: .leading) {
            HStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
               
                    Image("back_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
            })
           
                    Text("Profile")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
                Spacer()
                Button(action: {
                    isPressEditButton.toggle()
                }){
                    HStack(spacing: 22){
                        Text("Edit").font(.custom("Poppins-Bold", size: 16))
                            .foregroundColor(Color("head"))
                    }.padding(.trailing , 10)
                      
                    }
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider()
            
        }
        
    }
    //MARK:- Profile Image
    fileprivate func ProfileImage() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 12){
                WebImage(url:URL(string: userprofile.UserProfile?.data?.image ?? "")).resizable().placeholder(Image("Profile Picture")) .clipShape(Circle()).shadow(radius: 4).frame(width: 70 , height: 70).padding(.leading , 5)
                Text(userprofile.UserProfile?.data?.name ?? "").font(.custom("Poppins-Bold", size: 14))
                
            }
        }.padding([.bottom , .top] , 10).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
    }
    //MARK:- Profile Data setting
    fileprivate func UserProfileData() -> some View {
        VStack(spacing: 22){
            HStack{
                Text("Email").font(.custom("Poppins-Bold", size: 12))
                Spacer()
                Text(userprofile.UserProfile?.data?.email ?? "").font(.custom("Poppins-Regular", size: 12)).foregroundColor(Color("light"))
//                Image("Right").resizable().frame(width: 24 , height: 24)
                
            }
            HStack{
                Text("Change Password").font(.custom("Poppins-Bold", size: 12))
                Spacer()
                Text("************").font(.custom("Poppins-Regular", size: 12)).foregroundColor(Color("light"))
//                Image("Right").resizable().frame(width: 24 , height: 24)
                
            }
            HStack{
                Text("Fitness Level").font(.custom("Poppins-Bold", size: 12))
                Spacer()
                Text(userprofile.UserProfile?.data?.fitnessLevel ??
            "" ).font(.custom("Poppins-Regular", size: 12)).foregroundColor(Color("light"))
//                Image("Right").resizable().frame(width: 24 , height: 24)
                
            }
        
            
        }.padding().frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
        
    }
    //MARK:- Connect To smart Watch Button
    fileprivate func ConnectToWatchButton() -> some View {
        Button(action: {
            
            
            
        }, label: {
            Text("Connect To Smart Watch")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 14))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(5)
            
            
        })
        .frame( height: 50)
        .padding([.top], 30)
    }
    //MARK:- Logout Button
    fileprivate func LogoutButton() -> some View {
        Button(action: {
            
            logOut()
            
        }, label: {
            Text("Logout")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 14))
                .background(Color("LogoutButtonColor"))
                .foregroundColor(Color.white)
                .cornerRadius(5)
            
            
        })
        .frame( height: 50)
        .padding([.top], 5)
    }
    func logOut() {
        if let window = UIApplication.shared.windows.first {
               window.rootViewController = UIHostingController(rootView: LoginView())
               window.endEditing(true)
            AppHelper.helper.removeMyUser()
               window.makeKeyAndVisible()
           }
    }
    //MARK:- Link to Edit Profile
    private var goToEditProfile : some View {
        
        NavigationLink(destination: EditProfileView(),isActive: $isPressEditButton,
                       label: {
                        Text("")
                       })
        
    }
         
            
           
    
}

