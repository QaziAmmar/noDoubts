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
    @State var current_date = Date()
    @State var time = Date()
    @Binding var backToRunningList: Bool
//    @State private var time = String()
    @ObservedObject var addRunning : AddRunningViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(value: Binding<Bool>){
        _backToRunningList = value
        _addRunning = ObservedObject(wrappedValue: AddRunningViewModel(showHomePa: value))
        }
    var body: some View {
        loadView()
    }
}

struct AddRunningView_Previews: PreviewProvider {
    static var previews: some View {
        AddRunningView(value: .constant(false))
    }
}
//    MARK:- View Extension
extension AddRunningView{
    func loadView() -> some View {
        LoadingView(isShowing: $addRunning.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            RunningInputData()
            HStack(spacing: 10){
                RunningDateView()
                RunningTimeView()
            }.padding(.top , 6)
            AverageSpeed()
           
            AddRunningButton()
            Spacer()
            
        }.navigationBarHidden(true).modifier(BannerModifier(model: $addRunning.model))
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
           
                    Text("Running")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                
                
                Spacer()
                    
                
        }.frame(minWidth : 0 , maxWidth: .infinity ,alignment: .leading)
            
            
            Divider().padding([.leading] , 20)
            
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
            }.padding(.top , 40).padding(.trailing , 20).padding(.leading , 20)
    }
    //MARK:- Date View
    fileprivate func RunningDateView() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    
                    
                    
                    
                    HStack{
                        Text("Date")
                        
                        .background(Color.white)
                        .foregroundColor(Color.black)
                      //  .padding([.trailing, .top, .bottom])
                        .font(.custom("Poppins-Medium", size: 14))
                        
                        DatePicker("", selection: $current_date, displayedComponents: [.date])
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
            }.padding(.leading, 20)
            
    }
    //MARK:- Time View
    fileprivate func RunningTimeView() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(height: 50)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 3)
//                                .stroke(Color.gray, lineWidth: 0.5)
//                        )
                    
                    
                    
                    HStack(spacing: 0){
                        Text("Time")
                        
                        .background(Color.white)
                        .foregroundColor(Color.black)
                      //  .padding([.trailing, .top, .bottom])
                        .font(.custom("Poppins-Medium", size: 14))
                        
                        DatePicker("", selection: $time, displayedComponents: [.hourAndMinute])
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding(.trailing , 20)
//                            .padding([.trailing, .top, .bottom, .leading])
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
            }.padding(.top , 6).padding(.trailing , 20).padding(.leading , 20)
    }
    //MARK:- Add Running Button
    fileprivate func AddRunningButton() -> some View {
        Button(action: {
            if is_all_field_are_filled{
                let dateFormatter = DateFormatter()
                let timeFarmetter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                timeFarmetter.dateFormat = "h:mm a"
                let selectedTime = timeFarmetter.string(from: time)
                let selectedDate = dateFormatter.string(from: current_date)
                addRunning.addRunningApi(distance: distance, time: selectedTime, average_speed: averageSpeed, date: selectedDate)
            }
            
            
        }, label: {
            Text("Add Running")
                .frame(maxWidth: .infinity/*@
                       3@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 16))
                .foregroundColor(Color.white)
                .frame(height: 55)
                  
            
            
        })
        .background(Color("fg"))
        .cornerRadius(6)
        .frame(height : 55)
        .padding([.top ] ,200).padding(.trailing , 20).padding(.leading , 20)
        
    }
    //MARK:- Check all fields are filled
    var is_all_field_are_filled:  Bool{
        if (distance.isEmpty ||  averageSpeed.isEmpty){
            
            addRunning.model = BannerData(title: "All fields are required", message: "", color: .red, image: "error")
            return false
        }else{
            
            return true
        }
    }
}

