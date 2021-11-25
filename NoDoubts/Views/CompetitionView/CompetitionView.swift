//
//  CompetitionView.swift
//  NoDoubts
//
//  Created by Qazi on 04/09/2021.
//

import SwiftUI
import MapKit
import GoogleMaps


struct CompetitionView: View {
  
    @State private var Name = String()
    @State private var Place = String()
    @State private var Datee = String()
    @State private var UserAddress = String()
    @State var current_date = Date()
    @State private var Result = String()
    @State private var latitude : Double = 0.0
    @State private var longitude : Double = 0.0
    @State var loading = false
    @State var model: BannerData?
    @State private var loationNam : String = ""
    @ObservedObject private var watchLocationManager = WatchLocManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State  var locationNamee = [AnnotatedItem(coordinate: CLLocationCoordinate2D())]
    @Binding var backToList: Bool
    var userLatitude: Double {
            return watchLocationManager.lastLocation?.coordinate.latitude ?? 0
        }
        
        var userLongitude: Double {
            return watchLocationManager.lastLocation?.coordinate.longitude ?? 0
        }
    
  
    var body: some View {
       loadView()
    }
}
//    MARK:- View Extension
extension CompetitionView{
    func loadView() -> some View {
        LoadingView(isShowing: $loading) {
        VStack(alignment: .center) {
            BackButtonView()
            CompetitionName()
            HStack(spacing: 20){
                CompetitionDate()
                CompetitionPlace()
            }.padding(.top , 6)
            CompetitionResult()
            Text("Location").font(.custom("Poppins-Bold", size: 14)).frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 30, alignment: /*@START_MENU_TOKEN@*/.leading)
            GoogleMapsView2(latitude: userLatitude, longitude: userLatitude, address: UserAddress).frame(height: 150).cornerRadius(8)
            AddCompetitionButton()
            Spacer()
            
        }.modifier(BannerModifier(model: $model)).onAppear(){
            getAddressFromLatLon(pdblLatitude: userLatitude, withLongitude: userLongitude)
        }.onDisappear(){
            watchLocationManager.StopLocation()
        }.padding().navigationBarHidden(true)
        }
        
    }
    //MARK:- Back Button
    fileprivate func BackButtonView() -> some View {
        
        VStack(alignment: .leading) {
            HStack{
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }){
                HStack{
                    Image("back_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    Text("Competition")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                }
            }
                   Spacer()
                    
            }
            
            Divider()
            
        }
    }
    //MARK:- Competition Name
    fileprivate func CompetitionName() -> some View {
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
                        
                        TextField("Competition Name", text: $Name)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 20)
    }
    //MARK:-  Competition Date View
    fileprivate func CompetitionDate() -> some View {
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
                        Text("Date")
                        
                        .background(Color.white)
                        .foregroundColor(Color.black)
                      //  .padding([.trailing, .top, .bottom])
                        .font(.custom("Poppins-Medium", size: 14))
                        
                        DatePicker("", selection: $current_date, displayedComponents: [.date])
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding(.trailing , 20)
//                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.leading, 20)
    }
    //MARK:- Competition Place View
    fileprivate func CompetitionPlace() -> some View {
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
                        
                        TextField("Place", text: $UserAddress)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
    }
    //MARK:- Competitio Result View
    fileprivate func CompetitionResult() -> some View {
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
                        
                        TextField("Result", text: $Result)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }.padding(.top , 6)
    }
    //MARK:- Add Competition Button
    fileprivate func AddCompetitionButton() -> some View {
        Button(action: {
            if is_all_field_are_filled{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: current_date)
            ApiAddCompetition(name: Name, place: UserAddress, date: selectedDate, result: Result, lat: String(userLatitude), long: String(userLongitude))
            }else{
                print("Empty Fields")
            }
            
        }, label: {
            Text("Add Competition")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 14))
                
                .foregroundColor(Color.white)
               
            
            
        })
        .background(Color("fg"))
        .cornerRadius(6)
        .frame( height: 55)
        .padding([.top], 130)
    }
    //MARK:- Check all fields are filled
    var is_all_field_are_filled:  Bool{
        if (Name.isEmpty ||  Result.isEmpty){
            
            model = BannerData(title: "All fields are required", message: "", color: .red, image: "error")
            return false
        }else{
            
            return true
        }
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView(backToList: .constant(false))
    }
}
extension CompetitionView{
    func ApiAddCompetition(name: String, place: String, date: String, result: String, lat: String, long: String){
        
        
        loading = true
        guard let profile = AppHelper.helper.loadMyUser() else {
            print("No user")
            return
        }
        let userId = profile.data?.id ?? ""
        let param = ["user_id": userId,
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
                        self.loading = false
                        print(competitionsModels)
                        backToList.toggle()
                       
                    } else {
                        self.loading = false
                    }
                } catch let error {
                    self.loading = false
                    print(error)
                }
                
                
            } withapiFiluer: { error in
                self.loading = false
                print("\(error)")
            }
    }
}
extension CompetitionView{
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = pdblLatitude
            //21.228124
            let lon: Double = pdblLongitude
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
}

