//
//  EditProfileView.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var gender = String()
    @State private var name = String()
    @State private var age = String()
    @State private var email = String()
    @State private var changePassword = String()
    @State private var fitnessLvl = String()
    @State private var actionSheetIsPresented: Bool = false
    @State private var sheetIsPresented = false
    @State private var sourceType : UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var editProfile = EditProfileViewModel()
    var body: some View {
        LoadingView(isShowing: $editProfile.loading){
        VStack{
            ScrollView{
            BackButtonView()
            ProfileImage()
            UserProfileData()
            saveButton()
            Spacer()
        }
        }.onAppear(){
            guard let profile = AppHelper.helper.loadMyUser() else {
                print("No user")
                return
            }
            email = profile.data?.email ?? ""
            gender = profile.data?.gender ?? ""
            fitnessLvl = profile.data?.fitnessLevel ?? ""
            age = profile.data?.dateOfBirth ?? ""
            name = profile.data?.name ?? ""
            
            
           
        }.navigationBarHidden(true).ignoresSafeArea().padding(.top , 1).padding(.leading , 5).modifier(BannerModifier(model: $editProfile.model)).actionSheet(isPresented: self.$actionSheetIsPresented) {
            ActionSheet(title: Text(""), message: nil, buttons: [
                .default(Text("Camera"), action: {
                    self.sourceType = .camera
                    self.sheetIsPresented = true
                }),
                .default(Text("Gallery"), action: {
                    self.sourceType = .photoLibrary
                    self.sheetIsPresented = true
                }),
                .cancel()
            ])
        }
        .sheet(isPresented: self.$sheetIsPresented) {
            ImagePickerView(sourceType: self.sourceType, onCanceled: {
                // on cancel
            }) { (image) in
                
                
                guard let reduceImage = image?.resizedTo1MB()
                else {print("image not compressed");return}
                
                guard let compressedImage = reduceImage.jpegData(compressionQuality : 0.0) else {print("image not compressed");return}
                
                let compressImage = compressedImage.base64EncodedString()
//                ProfileImage = compressImage
//                APIProfilePictureUpdate()
                
                
            }
        
        
    }
    }
    }
    //MARK:- Back Button
    fileprivate func BackButtonView() -> some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack{
                    Image("back_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    Text("Profile")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                    Spacer()
                }
                
            }).padding()
            .padding([.leading], -15)
            
            Divider()
            
        }
    }
    //MARK:- Profile Image
    fileprivate func ProfileImage() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 12){
                ZStack(alignment: .bottomTrailing){
                Image("Profile Picture").resizable().frame(width: 70 , height: 70).padding(.leading , 5)
                    Button(action:  {
                        actionSheetIsPresented.toggle()
                    }) {
                    Image("CameraAction").resizable().frame(width: 30, height: 30).frame(alignment: .trailing).padding(.top , 4).padding(.trailing , -5).padding(.bottom , -3)
                    }
                }
                TextField(name, text: $name).font(.custom("Poppins-Bold", size: 14))
                
            }
        }.padding([.bottom , .top] , 10).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
    }
    //MARK:- Profile Data setting
    fileprivate func UserProfileData() -> some View {
        VStack(spacing: 10){
        
      
            Text("Gender").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
               
                TextField(gender, text: $gender)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .padding([.trailing, .top, .bottom])
                    .font(.custom("Poppins-Regular", size: 14))
                
            
            
            Text("Age").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
                
            TextField(age, text: $age)
                .background(Color.white)
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14))
                
                
            
            
                Text("Email").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
           
            TextField(email, text: $email)
                .background(Color.white)
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14))
                Text("Change Password").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            TextField("abc@gmail.com", text: $changePassword)
                .background(Color.white)
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14))
                
                Text("Fitness Level").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            TextField(fitnessLvl, text: $fitnessLvl)
                .background(Color.white)
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14))
               
               
                
            
        
            
        }.padding().frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
        
    }
    //MARK:- SetGoal Button
    fileprivate func saveButton() -> some View {
         Button(action: {
            editProfile.editProfileApi(name: "", image: "", password: changePassword, email: email, gender: gender, fitnessLvl: fitnessLvl)
            
        }) {
            Text("Save")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(6)
            
            
        }
         .frame( height: 55)
         .padding([.top], 20).padding([.leading , .trailing] , 16)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
