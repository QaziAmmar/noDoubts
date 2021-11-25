//
//  AddRunningView.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 08/10/2021.
//

import SwiftUI



struct AddRunningView: View {
    @State private var MoveToTimePicker: Bool = false
    @State private var MoveToDatePicker: Bool = false
    @State private var AlreadyCalled: Bool = true
    @State private var minutes : Int = 0
    @State private var hours : Int = 0
    @State private var Upcommingminutes : String = ""
    @State private var Upcominghours : String = ""
    @State private var day : Int = 0
    @State var showAlert = false
    @State private var month : Int = 0
    @State var isLoading = false
    @State private var year : Int = 0
    @State private var Starthours : String = ""
    @State private var StartTime : String = ""
    @State private var averageSpeed = String()
    @State private var Distance = String()
    var body: some View {
        VStack{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/){
        CompetitionName()
            HStack(spacing: 20){
                CompetitionDate()
                CompetitionPlace()
            }.padding(.top , 3).frame(height: 30)
            Result()
            CompetitionButton().padding(.top , 20)
                GoToTimePicker.hidden().frame(height: 0)
                GotoWatchDatePicker.frame(height: 0).hidden()
            Spacer()
            }
        }.onAppear{
            if AlreadyCalled{
            let date = Date()
            let dateFormatter = DateFormatter()
            let timeFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            timeFormatter.dateFormat = "yyyy-MM-dd"
                let dateTime = timeFormatter.string(from: date)
            let hour = dateFormatter.string(from: date)
                Starthours = hour
                StartTime = dateTime
           
            }else{
                for i in 0..<10{
                    if hours == i{
                        if minutes == i{
                            let chand = "0\(hours)"
                            Upcominghours = chand
                            Upcommingminutes = chand
                        }else{
                        let chand = "0\(hours)"
                        Upcominghours = chand
                        }
//                        print(hours)
                    }else if minutes == i{
                        let chand = "0\(minutes)"
                        Upcommingminutes = chand
                    }
                }
                print("Already Called")
            }
            
        } .alert(isPresented: self.$showAlert) {
            Alert(title: Text("All fields are required"), message: Text(""),
                  dismissButton: .default (Text("OK")) {}
                      
                 )
        }.navigationTitle("Add Running")
    }
    //MARK:- Competition Name
    fileprivate func CompetitionName() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    HStack {
                        
                        TextField("Distance", text: $Distance)
                            .frame(height: 30)
                            
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.clear).font(.custom("Poppins-SemiBold", size: 8)).foregroundColor(Color.white))
                            .foregroundColor(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).font(.custom("Poppins-SemiBold", size: 8))
                            
                            .cornerRadius(5)
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 5)
    }
    //MARK:-  Competition Date View
    fileprivate func CompetitionDate() -> some View {
         // VStack Top Logo
            
            VStack {
                if AlreadyCalled == true{
                Button(action: {
                    AlreadyCalled = false
                    MoveToDatePicker.toggle()
                    
                }){
                
                    Text(StartTime).font(.custom("Poppins-SemiBold", size: 8))
                    
                   
                        .frame(height: 30)
             
        }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                }else{
                    if (year == 0 && day == 0 && month == 0){
                        Button(action: {
                            AlreadyCalled = false
                            MoveToDatePicker.toggle()
                            
                        }){
                        
                            Text(StartTime).font(.custom("Poppins-SemiBold", size: 8))
                            
                           
                                .frame(height: 30)
                     
                }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                    }else{
                    Button(action: {
                        AlreadyCalled = false
                        MoveToDatePicker.toggle()
                        
                    }){
                    
                        Text(String("\(year)-\(month)-\(day)")).font(.custom("Poppins-SemiBold", size: 8))
                        
                       
                            .frame(height: 30)
                 
            }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                    }
                }
            }
    }
    //MARK:- Competition Place View
    fileprivate func CompetitionPlace() -> some View {
         // VStack Top Logo
            
            VStack {
                if AlreadyCalled == true{
                        Button(action: {
                            AlreadyCalled = false
                            MoveToTimePicker.toggle()
                            
                        }){
                            Text(Starthours)
                            //TextField("Time", text: $Name)
                                .frame(height: 30).font(.custom("Poppins-SemiBold", size: 8))
                                
                                
                            //.foregroundColor(Color.white)
                        }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                    
                    
                
                }else{
                    if (hours == 0 && minutes == 0){
                        Button(action: {
                            AlreadyCalled = false
                            MoveToTimePicker.toggle()
                            
                        }){
                            Text(Starthours)
                            //TextField("Time", text: $Name)
                                .frame(height: 30).font(.custom("Poppins-SemiBold", size: 8))
                                
                                
                            //.foregroundColor(Color.white)
                        }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                        
                    }else{
            
                        
                            Button(action: {
                                AlreadyCalled = false
                                MoveToTimePicker.toggle()
                                
                            }){
                            
                                Text("\(Upcominghours):\(Upcommingminutes)").font(.custom("Poppins-SemiBold", size: 8))
                                
                               
                                    .frame(height: 30)
                         
                    }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                    }
                }// :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Result
    fileprivate func Result() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    HStack {
                        
                        TextField("Average Speed", text: $averageSpeed)
                            .frame(height: 30)
                            
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.black).font(.custom("Poppins-SemiBold", size: 8)).foregroundColor(Color.white))
                            .foregroundColor(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).font(.custom("Poppins-SemiBold", size: 8))
                            
                            .cornerRadius(5)
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 3)
    }
    //MARK:- Add Competition Button
    fileprivate func CompetitionButton() -> some View {
         // VStack Top Logo
            
        Button(action:{
            if is_field_are_empty{
                if year == 0 || day == 0 || month == 0 || hours == 0 || minutes == 0{
                    addRunningApi(distance: Distance, time: Starthours, average_speed: averageSpeed, date: StartTime)
                }else{
                addRunningApi(distance: Distance, time: "\(Upcominghours):\(Upcommingminutes)", average_speed: averageSpeed, date: "\(year)-\(day)-\(month)")
                }
            }else{
                showAlert.toggle()
            }
        }){
            HStack{
            HStack(spacing: 8){
                Text("Add Running").font(.custom("Poppins-Bold", size: 8)).foregroundColor(.black).font(.custom("Poppins-Bold", size: 8)).frame(alignment: .center)
                
            }
               
            }.padding()
        }.frame(height: 35).background(Color(.white)).cornerRadius(4)
    }
    //MARK:- Check All field Is Filled
    var is_field_are_empty:  Bool {
        if(Distance.isEmpty || averageSpeed.isEmpty){
            
            return false
        }else{
            return true
        }
    }
    //MARK:- Go to Time Picker
    private var GoToTimePicker : some View {
        
        
        NavigationLink(destination: HLYTimePicker(hour: $hours, minute: $minutes),isActive: $MoveToTimePicker,
                       label: {
                        Text("")
                       })
        
    }
    
    //MARK:- Go to Time Picker
    private var GotoWatchDatePicker : some View {
        
        
        NavigationLink(destination: WatchDatePicker(day: $day, year: $year, month: $month),isActive: $MoveToDatePicker,
                       label: {
                        Text("")
                       })
        
    }

}

struct AddRunningView_Previews: PreviewProvider {
    static var previews: some View {
        AddRunningView()
    }
}
//MARK:- Add Running Api
extension AddRunningView{
    
    func addRunningApi(distance: String, time: String, average_speed: String, date: String){
        
        
        isLoading = true
//        guard let profile = AppHelper.helper.loadMyUser() else {
//            print("No user")
//            return
//        }
//        let userId = profile.data?.id ?? ""
        let param = ["user_id": "1",
                     "distance": distance,
                     "time": time,
                     "date": date,
                     "average_speed": average_speed
        ]as [String : Any]
            
            ApiManager.URLResponse("api/Workout/running", method: .post, parameters: param, headers: nil) { competitions in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let competitionsModels = try decoder.decode(addRunningModel.self, from: competitions)

                    if competitionsModels.status == 1 {
                        self.isLoading = false
                        print(competitionsModels)
                       
                    } else {
                        self.isLoading = false
                    }
                } catch let error {
                    self.isLoading = false
                    print(error)
                }
                
                
            } withapiFiluer: { error in
                self.isLoading = false
                print("\(error)")
            }
    }}
