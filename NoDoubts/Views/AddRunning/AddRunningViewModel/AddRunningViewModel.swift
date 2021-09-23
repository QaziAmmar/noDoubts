//
//  AddRunningViewModel.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import Foundation
class AddRunningViewModel: ObservableObject {
    @Published var addRunng : addRunningModel?
    @Published var loading = false
    @Published var model: BannerData?
  
    
    
    //MARK:- SignUp Api
    func addRunningApi(distance: String, time: String, average_speed: String, date: String){
        
            loading = true
        let param = ["user_id": "19",
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
                        self.loading = false
                        print(competitionsModels)
                        self.model = BannerData(title:  competitionsModels.message ?? "", message: competitionsModels.message, color: .green, image: "success")
                    } else {
                        //                    show error
                        self.model = BannerData(title: competitionsModels.message ?? "", message: competitionsModels.message, color: .red, image: "error")
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
