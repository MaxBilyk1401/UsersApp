//
//  UsersCollectionViewCell.swift
//  UsersApp
//
//  Created by Maxos on 6/13/23.
//

import UIKit

final class UsersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var firstNameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var detailsButton: UIButton!
    @IBOutlet weak private var genderImage: UIImageView!
    private var list = [UserModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setup(with user: UserModel) {
        firstNameLabel.text = "\(user.firstName)  \(user.lastName)"
        ageLabel.text = String(user.age)
        genderLabel.text = String(user.gender.title)
        
        let genderIcon: UIImage?
        if user.gender == .male {
            genderIcon = UIImage(named: "Male")
        } else {
            genderIcon = UIImage(named: "Female")
        }
        genderImage.image = genderIcon
    }
    
    private func setupLayout() {
        layer.cornerRadius = 16
        backgroundColor = .white
        layer.borderWidth = 0.50
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 8
        layer.masksToBounds = false
        detailsButton.layer.cornerRadius = 20.0
    }
}
