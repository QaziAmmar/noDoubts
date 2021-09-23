//
//  AddStrengthView.swift
//  NoDoubts
//
//  Created by Qazi Ammar Arshad on 25/08/2021.
//

import SwiftUI

struct AddStrengthView: View {
    @ObservedObject var addStrength = AddStrengthViewModel()
    @State private var Name = String()
    @State private var duration = String()
    @State private var date = String()
    @State private var time = String()
    @State private var weight = String()
    @State private var reps = String()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        loadView()
    }
}

struct AddStrengthView_Previews: PreviewProvider {
    static var previews: some View {
        AddStrengthView()
    }
}
//    MARK:- View Extension
extension AddStrengthView{
    func loadView() -> some View {
        LoadingView(isShowing: $addStrength.loading) {
        VStack(alignment: .center) {
            BackButtonView()
            StrengthInputData()
            HStack(spacing: 20){
            StrengthDateData()
                StrengthTime()
            }.padding(.top , 6)
            DurationView()
            HStack(spacing: 20){
                RepsView()
                WeightView()
            }.padding(.top , 6)
            AddStrengthButton()
            Spacer()
            
        }.padding().modifier(BannerModifier(model: $addStrength.model))
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
                    Text("Strength")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                   
                }
                
            }).padding()
            .padding([.leading], -30)
            
            Divider()
            
        }
    }
    //MARK:- Strength data
    fileprivate func StrengthInputData() -> some View {
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
                        
                        TextField("Strength Name", text: $Name)
                            
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
    fileprivate func StrengthDateData() -> some View {
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
    fileprivate func StrengthTime() -> some View {
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
    //MARK:- Duration View
    fileprivate func DurationView() -> some View {
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
                        
                        TextField("Duration", text: $duration)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 6)
    }
    //MARK:- Reps View
    fileprivate func RepsView() -> some View {
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
                        
                        TextField("Reps", text: $reps)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:-WeightView
    fileprivate func WeightView() -> some View {
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
                        
                        TextField("Weight(optional)", text: $weight)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Add Strength Button
    fileprivate func AddStrengthButton() -> some View {
        Button(action: {
            if is_all_field_are_filled{
                addStrength.ApiAddStrength(duration: duration, time: time, reps: reps, date: date, name: Name, weight: weight)
            }
            
            
        }, label: {
            Text("Add Strength")
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
        if (duration.isEmpty || date.isEmpty || time.isEmpty || reps.isEmpty || Name.isEmpty){
            
            addStrength.model = BannerData(title: "All fields are required", message: "", color: .red, image: "error")
            return false
        }else{
            
            return true
        }
    }

}
