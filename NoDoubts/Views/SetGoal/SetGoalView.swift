//
//  SetGoalView.swift
//  NoDoubts
//
//  Created by Qazi on 06/09/2021.
//

import SwiftUI

struct SetGoalView: View {
    @State private var Name = String()
    @State private var descriptionName = "Description"
    @State private var placeholderString = "Description"
    @Binding var backToList: Bool
    @ObservedObject var setGoal : SetGoalViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(value: Binding<Bool>){
        _backToList = value
        _setGoal = ObservedObject(wrappedValue: SetGoalViewModel(showGoal: value))
        }
    var body: some View {
        LoadingView(isShowing: $setGoal.loading) {
            VStack{
                BackButtonView()
                GoalName()
                Description()
                SetGHoalButton()
                Spacer()
            }.navigationBarHidden(true) .modifier(BannerModifier(model: $setGoal.model))
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
                    Text("Goals")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                   //Spacer()
                }
                
            }).padding(.leading , 0).padding(.top , 30)
            //.padding([.leading], -30)
            
            Divider()
            
        }
    }
    //MARK:- Goal Name
    fileprivate func GoalName() -> some View {
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
                        
                        TextField("Goal Name", text: $Name)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding()
    }
    //MARK:- description Name
    fileprivate func Description() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack {
                        TextEditor(text: $descriptionName).padding([.trailing, .top, .bottom, .leading]).frame(height: 200, alignment: .leading).font(.custom("Poppins-Regular", size: 14))
                            .foregroundColor(self.descriptionName == placeholderString ? .gray : .black)
                            .onTapGesture {
                                                if self.descriptionName == placeholderString {
                                                    self.descriptionName = ""
                                                }
                                            }
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 0).padding([.leading, .trailing] , 16)
    }
    //MARK:- SetGoal Button
    fileprivate func SetGHoalButton() -> some View {
         Button(action: {
            if is_field_are_empty{
                setGoal.setGoalApi(name: Name, description: descriptionName)
            }
           
            
        }, label: {
            Text("Set Goal")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
               
                .foregroundColor(Color.white)
                
            
            
        })
         .background(Color("fg"))
         .cornerRadius(6)
         .frame( height: 55)
         .padding([.top], 130).padding([.leading , .trailing] , 16)
    }
    //MARK:- Check All field Is Filled
    var is_field_are_empty:  Bool {
        if(Name.isEmpty || descriptionName.isEmpty){
            setGoal.model = BannerData(title: "Error", message: "Please fill all the fields", color: .red, image: "error")
            return false
        }else{
            return true
        }
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView(value: .constant(false  ))
    }
    
}

