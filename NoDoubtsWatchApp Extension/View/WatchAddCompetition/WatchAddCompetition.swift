//
//  WatchAddCompetition.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 08/10/2021.
//

import SwiftUI

struct WatchAddCompetition: View {
    @State private var Name = String()
    @State private var Results = String()
    @State private var month : Int = 0
    @State private var MoveToDatePicker: Bool = false
    @State private var year : Int = 0
    @State private var day : Int = 0
    @State var isLoading = false
    @State var showAlert = false
    @State private var Starthours : String = ""
    @State private var AlreadyCalled: Bool = true
    @State private var UserAddress = String()
    @ObservedObject var watchLocationManager = WatchLocManager()
    var userLatitude: String {
            return "\(watchLocationManager.lastLocation?.coordinate.latitude ?? 0)"
        }
        
        var userLongitude: String {
            return "\(watchLocationManager.lastLocation?.coordinate.longitude ?? 0)"
        }
    var body: some View {
        VStack{
            ZStack(alignment: .center){
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/){
                if isLoading{
                LoadingView()
                }
                VStack{
        CompetitionName()
            
                CompetitionDate()
                CompetitionPlace()
           
            Result()
            CompetitionButton().padding(.top , 20)
                GotoWatchDatePicker.frame(height: 0).hidden()
                }
           
            }
                Spacer()
            }
        }.onAppear {
            if AlreadyCalled{
            let date = Date()
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
            let hour = dateFormatter.string(from: date)
                Starthours = hour
           
            }
            
            getAddressFromLatLon(pdblLatitude: userLatitude, withLongitude: userLongitude)
        } .alert(isPresented: self.$showAlert) {
            Alert(title: Text("All fields are required"), message: Text(""),
                  dismissButton: .default (Text("OK")) {}
                      
                 )
        }.onDisappear(){
            watchLocationManager.StopLocation()
        }.navigationTitle("Add Competition")
    }
    //MARK:- Competition Name
    fileprivate func CompetitionName() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    
                    
                    
                    
                    HStack {
                        
                        TextField("Competition Name", text: $Name)
                            .frame(height: 30)
                            
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.black).font(.custom("Poppins-SemiBold", size: 8)).foregroundColor(Color.white))
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
                
                    Text(Starthours).font(.custom("Poppins-SemiBold", size: 8))
                    
                   
                        .frame(height: 30)
             
        }.buttonStyle(PlainButtonStyle()).frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: 30, alignment: .center).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).background(Color.black)
                }else{
                    if (year == 0 && day == 0 && month == 0){
                        Button(action: {
                            AlreadyCalled = false
                            MoveToDatePicker.toggle()
                            
                        }){
                        
                            Text(Starthours).font(.custom("Poppins-SemiBold", size: 8))
                            
                           
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
                ZStack(alignment: .leading) {
                    
                   
                    
                    
                    
                    HStack{
                        
                        TextField("Place", text: $UserAddress)
                            
                            .frame(height: 30)
                            
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.black).font(.custom("Poppins-SemiBold", size: 8)).foregroundColor(Color.white))
                            .foregroundColor(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).font(.custom("Poppins-SemiBold", size: 8))
                            
                            .cornerRadius(5)
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Result
    fileprivate func Result() -> some View {
         // VStack Top Logo
            
            VStack {
                ZStack(alignment: .leading) {
                    
                    
                    
                    
                    
                    HStack {
                        
                        TextField("Result", text: $Results)
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
                if year == 0 || day == 0 || month == 0{
                    ApiAddCompetition(name: Name, place: UserAddress, date: Starthours, result: Results, lat: userLatitude, long: userLongitude)
                }else{
                ApiAddCompetition(name: Name, place: UserAddress, date: "\(year)-\(day)-\(month)", result: Results, lat: userLatitude, long: userLongitude)
                }
            }else{
                showAlert.toggle()
            }
        }){
            HStack{
            HStack(spacing: 8){
               
            
                Text("Add Competition").font(.custom("Poppins-Bold", size: 8)).foregroundColor(.black).font(.custom("Poppins-Bold", size: 8)).frame(alignment: .center)
                
            }
               
            }.padding()
        }.frame(height: 35).background(Color(.white)).cornerRadius(4)
    }
    //MARK:- Go to Time Picker
    private var GotoWatchDatePicker : some View {
        
        
        NavigationLink(destination: WatchDatePicker(day: $day, year: $year, month: $month),isActive: $MoveToDatePicker,
                       label: {
                        Text("")
                       })
        
    }
    //MARK:- Check all fields are filled
    var is_field_are_empty:  Bool {
        if(Name.isEmpty || Results.isEmpty || UserAddress.isEmpty){
            
            return false
        }else{
            return true
        }
    }
}

struct WatchAddCompetition_Previews: PreviewProvider {
    static var previews: some View {
        WatchAddCompetition()
    }
}
extension WatchAddCompetition{
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = (placemarks ?? [CLPlacemark]()) as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country ?? "")
                        print(pm.locality ?? "")
                        print(pm.subLocality ?? "")
                        print(pm.thoroughfare ?? "")
                        print(pm.postalCode ?? "")
                        print(pm.subThoroughfare ?? "")
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        UserAddress = addressString
                        print(addressString)
                  }
            })

        }
    //MARK:- Loader
    func LoadingView() -> some View {
       
         return ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        
    }
}
//MARK:- Api Calling
extension WatchAddCompetition{
    
    func ApiAddCompetition(name: String, place: String, date: String, result: String, lat: String, long: String){
        
        
        isLoading = true
//        guard let profile = AppHelper.helper.loadMyUser() else {
//            print("No user")
//            return
//        }
//        let userId = profile.data?.id ?? ""
        let param = ["user_id": "1",
                     "name": name,
                     "date": date,
                     "result": result,
                     "place": place,
                     "lat": lat,
                     "long": long
        ]as [String : Any]
        print(param)
            
            ApiManager.URLResponse("api/Workout/competition", method: .post, parameters: param, headers: nil) { competitions in
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
