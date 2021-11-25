//
//  EditProfileView.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var gender = String()
    @State private var name = String()
    @State private var profilePic = String()
   
    @State private var age = String()
    @State private var email = String()
    @State private var changePassword = String()
    @State private var fitnessLvl = String()
    @State private var actionSheetIsPresented: Bool = false
    @State private var sheetIsPresented = false
    @State private var sourceType : UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var editProfile = EditProfileViewModel()
    static var uniqueKey: String {
            UUID().uuidString
        }
    static let options: [DropdownOption] = [
            DropdownOption(key: uniqueKey, value: "Cardiovascular Endurance"),
            DropdownOption(key: uniqueKey, value: "Muscular Strength"),
            DropdownOption(key: uniqueKey, value: "Muscular endurance"),
            DropdownOption(key: uniqueKey, value: "Flexibility"),
            DropdownOption(key: uniqueKey, value: "Body Composition"),
            
        ]
    var body: some View {
        LoadingView(isShowing: $editProfile.loading){
        VStack{
            ScrollView{
            BackButtonView()
            ProfileImage()
            UserProfileData()
            
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
            profilePic = profile.data?.image ?? ""
            let userPass = UserDefaults.standard.string(forKey: "UserPassword")
            changePassword = userPass ?? ""
            
            
           
        }.onChange(of: editProfile.changeProfile, perform: { value in
            guard let userProfile = AppHelper.helper.loadMyUser() else{
                return
            }
            email = userProfile.data?.email ?? ""
            gender = userProfile.data?.gender ?? ""
            fitnessLvl = userProfile.data?.fitnessLevel ?? ""
            age = userProfile.data?.dateOfBirth ?? ""
            name = userProfile.data?.name ?? ""
            profilePic = userProfile.data?.image ?? ""
           
        }).navigationBarHidden(true).ignoresSafeArea().padding(.top , 1).padding(.leading , 5).modifier(BannerModifier(model: $editProfile.model)).actionSheet(isPresented: self.$actionSheetIsPresented) {
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
                profilePic = compressImage
                editProfile.editProfileImageAPI(image: profilePic)
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
                    WebImage(url:URL(string: profilePic)).resizable().placeholder(Image("Profile Picture")) .clipShape(Circle()).shadow(radius: 4).frame(width: 70 , height: 70).padding(.leading , 5)
                    Button(action:  {
                        actionSheetIsPresented.toggle()
                    }) {
                    Image("CameraAction").resizable().frame(width: 30, height: 30).frame(alignment: .trailing).padding(.top , 4).padding(.trailing , -5).padding(.bottom , -3)
                    }
                }
                    
                TextField(name, text: $name).font(.custom("Poppins-Bold", size: 14))
             
                
            }
        }.padding([.bottom , .top] , 10).frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
    }
    //MARK:- Profile Data setting
    fileprivate func UserProfileData() -> some View {
        VStack(spacing: 10){
            
            
                Text("Email").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
           
            TextField(email, text: $email)
                .background(Color.white)
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14)).textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Change Password").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            SecureField("abc@gmail.com", text: $changePassword)
                .background(Color.white).textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(Color.black)
                .padding([.trailing, .top, .bottom])
                .font(.custom("Poppins-Regular", size: 14))
                
                Text("Fitness Level").font(.custom("Poppins-Bold", size: 12)).frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            ZStack(alignment: .top){
                VStack{
          
                        DropdownSelector(
                            placeholder: fitnessLvl,
                            options: SignUpView.options,
                            onOptionSelected: { option in
                                print(option)
                                fitnessLvl = option.value
                            }).zIndex(1)
                    saveButton()
                }
            }

               
               
                
            
        
            
        }.padding().frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .leading)
        
    }
    //MARK:- SetGoal Button
    fileprivate func saveButton() -> some View {
         Button(action: {
            editProfile.editProfileApi(name: name, password: changePassword, email: email, gender: gender, fitnessLvl: fitnessLvl)
            
        }) {
            Text("Save")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(6).disabled(editProfile.ButtonDisable)
            
            
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
