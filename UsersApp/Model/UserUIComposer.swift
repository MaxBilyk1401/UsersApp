//
//  UserUIComposer.swift
//  UsersApp
//
//  Created by Maxos on 6/12/23.
//

import UIKit

final class UserUIComposer {
    
    static func build() -> UITableViewController {
        let vc = UsersViewController()
        let viewModel = UserViewModel()
        vc.viewModel = viewModel
        return vc
    }
    
    private init() {}
}
