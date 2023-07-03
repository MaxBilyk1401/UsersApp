//
//  UserUIComposer.swift
//  UsersApp
//
//  Created by Maxos on 6/12/23.
//

import UIKit

final class UserUIComposer {
    
    static func build() -> UIViewController {
        let vc = CombinedViewController()
        let viewModel = UserViewModel()
        vc.viewModel = viewModel
        return vc
    }
    
    private init() {}
}
