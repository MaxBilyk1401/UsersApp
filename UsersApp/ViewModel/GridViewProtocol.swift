//
//  GridViewProtocol.swift
//  UsersApp
//
//  Created by Maxos on 6/16/23.
//

import Foundation

protocol GridViewProtocol {
    func showLoading(_ isLoading: Bool)
    func displayUsers(_ users: [UserModel])
    func showError(_ error: String)
}
