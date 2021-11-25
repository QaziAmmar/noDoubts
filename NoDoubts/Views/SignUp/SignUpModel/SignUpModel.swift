//
//  SignUpModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
struct SignUpModels : Codable {

        let data : SignUp?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct SignUp : Codable {

    let createdAt : String?
            let dateOfBirth : String?
            let email : String?
            let emailCode : String?
            let fitnessLevel : String?
            let gender : String?
            let id : String?
            let image : String?
            let modified : String?
            let name : String?
            let password : String?

        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
                         case dateOfBirth = "date_of_birth"
                         case email = "email"
                         case emailCode = "email_code"
                         case fitnessLevel = "fitness_level"
                         case gender = "gender"
                         case id = "id"
                         case image = "image"
                         case modified = "modified"
                         case name = "name"
                         case password = "password"
        }
}
struct socialLoginModel: Codable {
    
    let data : clientsDat?
    let message : String?
    let status : Bool?
//    let shopId : Int?
    enum CodingKeys: String, CodingKey {
//        case shopId = "shop_id"
        case message = "message"
        case status = "status"
        case data = "data"
    }
    
}
struct clientsDat : Codable {
            let aCode : String?
            let code : Int?
            let createdAt : String?
            let email : String?
            let fCode : String?
            let fbToken : String?
            let gToken : String?
            let id : Int?
            let name : String?
            let nationality : String?
            let password : String?
            let status : Int?
            let userToken : String?
            let userType : String?
            let shoRergister : Int?
    enum CodingKeys: String, CodingKey {
                    case aCode = "a_code"
                    case shoRergister = "shop_registered"
                    case code = "code"
                    case createdAt = "created_at"
                    case email = "email"
                    case fCode = "f_code"
                    case fbToken = "fb_token"
                    case gToken = "g_token"
                    case id = "id"
                    case name = "name"
                    case nationality = "nationality"
                    case password = "password"
                    case status = "status"
                    case userToken = "user_token"
                    case userType = "user_type"
            }
}

