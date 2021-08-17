//
//  WebServices.swift
//  Qarinli
//
//  Created by Abdur Rauf on 08/09/2020.
//  Copyright © 2020 Abdur Rauf. All rights reserved.

import Foundation
import Alamofire



typealias apiSuccess = (_ data: Data) -> ()
typealias apiFailure = (_ errorString: String) -> ()
typealias HTTPfailure = (_ errorString: String) -> ()


struct ApiResponse<T: Codable>: Codable {
    let status, response_message , reponse_type , message : String?
    let success : Bool?
    let data: T?
    var token = ""
}

class ApiManager {
    
    static let baseUrl = "https://5f.megaxtudio.com/index.php/Auth/"
    
    class func URLResponse(_ url:String, method: HTTPMethod ,parameters: [String: Any]?, headers: String?,  withSuccess success: @escaping apiSuccess, withapiFiluer failure: @escaping apiFailure) {
        
        var completeUrl : String = baseUrl + url
        completeUrl = completeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? completeUrl
        print(completeUrl)
//        let userToken = UserDefaults.standard.string(forKey: "token") ?? ""
        
        let headersToken: HTTPHeaders = [
            "ClientService": "ListC@rlIsT(;)*&-#$%",
            "AuthKey": "#$%%^^S@fTy!@).(@^S@fTy!@).(@",
            "token": UserDefaults.standard.string(forKey: UserDefaultEnum.token.rawValue) ?? ""
        ]

        AF.request(completeUrl, method:method, parameters: parameters, encoding: URLEncoding.httpBody, headers:headersToken).validate(statusCode: 200..<600).responseData(completionHandler: {   respones in
            switch respones.result {
                
            case .success(let value):
                print(respones.result)
                success(value)
                
            case .failure(let error):
                failure(error.localizedDescription)
            }
        })
    }
    
}

