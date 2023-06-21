//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Maxos on 6/12/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var genderImageView: UIImageView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var genderLabel: UILabel!
    private var list = [UserModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setup(with user: UserModel) {
        firstNameLabel.text = "\(user.firstName) \(user.lastName)"
        ageLabel.text = "\(user.age) y.o."
        genderLabel.text = String(user.gender.title)
        
        let genderIcon: UIImage?
        if user.gender == .male {
            genderIcon = UIImage(named: "Male")
        } else {
            genderIcon = UIImage(named: "Female")
        }
        genderImageView.image = genderIcon
        iconImageView.image = nil
        iconImageView.setImage(with: user.avatar)
        iconImageView.layer.cornerRadius = min(iconImageView.frame.width, iconImageView.frame.height) / 2
    }
    
    private func setupLayout() {
        actionButton.setTitle("", for: .normal)
        actionButton.tintColor = .white
        actionButton.backgroundColor = UIColor(named: "borderButtonColor")
        actionButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        actionButton.layer.cornerRadius = 16.0
    }
}
