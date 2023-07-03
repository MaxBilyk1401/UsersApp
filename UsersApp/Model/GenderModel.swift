//
//  GenderModel.swift
//  UsersApp
//
//  Created by Maxos on 6/12/23.
//

import Foundation

enum GenderModel: String, CodingKey, Decodable, CaseIterable {
    case female = "F"
    case male = "M"
    
    var title: String {
        switch self {
        case .female:
            return "Female"
            
        case .male:
            return "Male"
        }
    }
}
