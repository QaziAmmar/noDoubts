//
//  CompetitionView.swift
//  NoDoubts
//
//  Created by Qazi on 04/09/2021.
//

import SwiftUI
import MapKit


struct CompetitionView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402) , span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var Name = String()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
       loadView()
    }
}
//    MARK:- View Extension
extension CompetitionView{
    func loadView() -> some View {
        VStack(alignment: .center) {
            BackButtonView()
            CompetitionName()
            HStack(spacing: 20){
                CompetitionDate()
                CompetitionPlace()
            }.padding(.top , 6)
            CompetitionResult()
            Text("Location").font(.custom("Poppins-Bold", size: 14)).frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 30, alignment: /*@START_MENU_TOKEN@*/.leading)
            Map(coordinateRegion: $region).frame(height: 150).cornerRadius(8)
            AddCompetitionButton()
            Spacer()
            
        }.padding()
        
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
                    Text("Competition")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(Color("head"))
                   Spacer()
                    HStack(spacing: 22){
                        Image("Vector").resizable().frame(width: 28 , height: 28)
                        Image(systemName: "plus").resizable().frame(width: 22 , height: 22)
                    }
                    
                }
                
            }).padding()
            .padding([.leading], -30)
            
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
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    
                    
                    
                    HStack{
                        
                        TextField("Date", text: $Name)
                            
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding([.trailing, .top, .bottom, .leading])
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                        
                       
                        
                    }
                    
                } // :ZStack Email
            // :ZStack Password
            }
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
                        
                        TextField("Place", text: $Name)
                            
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
                        
                        TextField("Result", text: $Name)
                            
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
            
            
            
        }, label: {
            Text("Add Competition")
                .frame(maxWidth: .infinity/*@END_MENU_TOKEN@*/, maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center)
                .font(.custom("Poppins-Bold", size: 14))
                .background(Color("fg"))
                .foregroundColor(Color.white)
                .cornerRadius(5)
            
            
        })
        .frame( height: 55)
        .padding([.top], 130)
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView()
    }
}
