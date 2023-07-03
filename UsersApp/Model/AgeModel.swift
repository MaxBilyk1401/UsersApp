//
//  AgeModel.swift
//  UsersApp
//
//  Created by Maxos on 6/27/23.
//

import Foundation

enum AgeModel: String, CodingKey, Decodable, CaseIterable {
    case descending = "D"
    case ascending = "A"
    
    var title: String {
        switch self {
        case .descending:
            return "Descending"
        case .ascending:
            return "Ascending"
        }
    }
}
