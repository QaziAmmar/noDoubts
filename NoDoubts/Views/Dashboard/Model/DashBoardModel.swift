//
//  DashBoardModel.swift
//  NoDoubts
//
//  Created by Qazi on 18/09/2021.
//

import Foundation
struct DashboardModel : Codable {

        let data : dashBoard?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
}
struct dashBoard : Codable {

        let competition : String?
        let goal : String?
        let quotation : String?
        let running : String?
        let strength : String?

        enum CodingKeys: String, CodingKey {
                case competition = "competition"
                case goal = "goal"
                case quotation = "quotation"
                case running = "running"
                case strength = "strength"
        }
}
