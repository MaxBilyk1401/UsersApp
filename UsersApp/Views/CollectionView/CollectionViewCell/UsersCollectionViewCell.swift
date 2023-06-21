//
//  UsersCollectionViewCell.swift
//  UsersApp
//
//  Created by Maxos on 6/13/23.
//

import UIKit

final class UsersCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var detailsButton: UIButton!
    @IBOutlet private weak var genderImage: UIImageView!
    private var list = [UserModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setup(with user: UserModel) {
        firstNameLabel.text = "\(user.firstName)  \(user.lastName)"
        ageLabel.text = "\(user.age) y.o."
        genderLabel.text = String(user.gender.title)
        
        let genderIcon: UIImage?
        if user.gender == .male {
            genderIcon = UIImage(named: "Male")
        } else {
            genderIcon = UIImage(named: "Female")
        }
        genderImage.image = genderIcon
        iconImageView.image = nil
        iconImageView.setImage(with: user.avatar)
        iconImageView.layer.cornerRadius = min(iconImageView.frame.width, iconImageView.frame.height) / 2
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
        detailsButton.layer.cornerRadius = 16.0
    }
}
