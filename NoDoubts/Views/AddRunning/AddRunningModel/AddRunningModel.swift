//
//  AddRunningModel.swift
//  NoDoubts
//
//  Created by Qazi on 15/09/2021.
//

import Foundation
struct addRunningModel: Codable {
    let message : String?
    let status : Int?
    enum CodingKeys: String, CodingKey {
            case message = "message"
            case status = "status"
    }

}
