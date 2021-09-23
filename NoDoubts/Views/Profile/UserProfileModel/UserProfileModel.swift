//
//  UserProfileModel.swift
//  NoDoubts
//
//  Created by Qazi on 21/09/2021.
//

import Foundation
struct UserProfileModel : Codable {

        let data : UserProfile?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct UserProfile : Codable {

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
