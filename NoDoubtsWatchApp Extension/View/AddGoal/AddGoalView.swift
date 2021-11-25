//
//  AddGoalView.swift
//  NoDoubtsWatchApp Extension
//
//  Created by Qazi on 06/10/2021.
//

import SwiftUI

struct AddGoalView: View {
    @State private var Name = String()
    @State var showAlert = false
    @State private var descriptionName = String()
    @State var isLoading = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
       
           
            ZStack(alignment: .center){
                ScrollView(showsIndicators: true){
                
                    VStack{
                        GoalName().padding(.top , 15)
                        Description().padding(.top,  8)
                        GoalButton().padding(.top , 30)
                    }
                
            }
            
            Spacer()
            }
     
        
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("All fields are required"), message: Text(""),
                  dismissButton: .default (Text("OK")) {}
                      
                 )
        }.navigationTitle("Add Goals")
        if isLoading{
            LoadingView().frame(height: 50)
//            Rectangle()
//                            .fill(Color.clear)
//                           .allowsHitTesting(false)
        }
    }
    //MARK:- Goal Name
    fileprivate func GoalName() -> some View {
         
                
                    TextField("Goal Name", text: self.$Name)
                        .frame(height: 30)
                        
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.black).font(.custom("Poppins-SemiBold", size: 8)).foregroundColor(Color.white))
                        .foregroundColor(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).font(.custom("Poppins-SemiBold", size: 8))
                        
                        .cornerRadius(5)
                        
                        
                            
                           
                           
          
            }
    //MARK:- Description
    fileprivate func Description() -> some View {
         
                
                    TextField("Description", text: self.$descriptionName)
                        .frame(height: 44)
                        
                        .textFieldStyle(PlainTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray)).multilineTextAlignment(.leading)
                        .cornerRadius(5)
                            .foregroundColor(Color.white).font(.custom("Poppins-SemiBold", size: 8))
        
    
          
            }
    //MARK:- Add Goal Button
    fileprivate func GoalButton() -> some View {
         // VStack Top Logo
            
        Button(action:{
           
            if is_field_are_empty{
                setGoalApi(name: Name, description: descriptionName)
            }else{
                showAlert.toggle()
            }
        }){
            HStack{
            HStack(spacing: 8){
               
            
                Text("Add Goals").font(.custom("Poppins-Bold", size: 8)).foregroundColor(.black).font(.custom("Poppins-Bold", size: 8)).frame(alignment: .center)
                
            }
               
            }.padding()
        }.frame(height: 35).background(Color(.white)).cornerRadius(4)
    }
    //MARK:- Loader
    func LoadingView() -> some View {
       
         return ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        
    }
    //MARK:- Check All field Is Filled
    var is_field_are_empty:  Bool {
        if(Name.isEmpty || descriptionName.isEmpty){
            
            return false
        }else{
            return true
        }
    }
    
    
}

struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView()
    }
}
//MARK:- Api Add Goal
extension AddGoalView{
    func setGoalApi(name: String , description: String){
        
            isLoading = true
//        guard let profile = AppHelper.helper.loadMyUser() else{
//            return
//        }
//        let userId = profile.data?.id ?? ""
            let parameters = ["user_id": "1",
                              "name": name,
                              "description": description
            ] as [String : Any]
            
            ApiManager.URLResponse("api/Workout/goal", method: .post, parameters: parameters, headers: nil) { loginData in
                //            parse login data
                do {
                    let decoder = JSONDecoder()
                    let loginModel = try decoder.decode(SetGoalModel.self, from: loginData)

                    if loginModel.status == 1 {
                        self.isLoading = false
                        print(loginModel)
                        
                    } else {
                        //                    show error
                        
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


