//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Maxos on 6/12/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    private var list = [UserModel]()
    
    func setup(with user: UserModel) {
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        ageLabel.text = String(user.age)
        genderLabel.text = user.gender.stringValue
    }
}
