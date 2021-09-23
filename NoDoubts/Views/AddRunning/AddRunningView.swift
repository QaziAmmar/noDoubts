//
//  AddRunningView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI

struct AddRunningView: View {
    @State private var averageSpeed = String()
    @State private var distance = String()
    @State private var date = String()
    @State private var time = String()
    @ObservedObject var addRunning = AddRunningViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        loadView()
    }
}

struct AddRunningView_Previews: PreviewProvider {
    static var previews: some View {
        AddRunningView()
    }
}
//    MARK:- View Extension
extension AddRunningView{
    func loadView() -> some View {
        LoadingView(isShowing: $addRunning.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            RunningInputData()
            HStack(spacing: 20){
                RunningDateView()
                RunningTimeView()
            }.padding(.top , 6)
            AverageSpeed()
           
            AddRunningButton()
            Spacer()
            
        }.padding().modifier(BannerModifier(model: $addRunning.model))
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
                    Text("Running")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                   
                }
                
            }).padding()
            .padding([.leading], -30)
            
            Divider()
            
        }
    }
    //MARK:- Strength data
    fileprivate func RunningInputData() -> some View {
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
                        
                        TextField("Distance", text: $distance)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 40)
    }
    //MARK:- Date View
    fileprivate func RunningDateView() -> some View {
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
                    
                    
                    
                    HStack{
                        
                        TextField("Date", text: $date)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Time View
    fileprivate func RunningTimeView() -> some View {
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
                    
                    
                    
                    HStack{
                        
                        TextField("Time", text: $time)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Average Speed View
    fileprivate func AverageSpeed() -> some View {
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
                        
                        TextField("Average Speed", text: $averageSpeed)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 6)
    }
    //MARK:- Add Running Button
    fileprivate func AddRunningButton() -> some View {
        Button(action: {
            if is_all_field_are_filled{
                addRunning.addRunningApi(distance: distance, time: time, average_speed: averageSpeed, date: date)
            }
            
            
        }, label: {
            Text("Add Running")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 14))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(5)
            
            
        })
        .frame( height: 50)
        .padding([.top], 200)
    }
    //MARK:- Check all fields are filled
    var is_all_field_are_filled:  Bool{
        if (distance.isEmpty || date.isEmpty || time.isEmpty || averageSpeed.isEmpty){
            
            addRunning.model = BannerData(title: "All fields are required", message: "", color: .red, image: "error")
            return false
        }else{
            
            return true
        }
    }
}

