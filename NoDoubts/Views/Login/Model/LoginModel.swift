//
//  LoginModel.swift
//  NoDoubts
//
//  Created by Qazi on 11/09/2021.
//

import Foundation
struct LoginModel : Codable {

        let data : Login?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct Login : Codable {

        let email : String?
        let id : String?
        let image : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case email = "email"
                case id = "id"
                case image = "image"
                case name = "name"
        }
}
