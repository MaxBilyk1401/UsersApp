//
//  UIImage+Extensions.swift
//  UsersApp
//
//  Created by Maxos on 6/20/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(with stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        setImage(with: imageURL)
    }
    
    func setImage(with url: URL) {
        self.kf.setImage(
            with: .network(url),
            placeholder: nil,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ]
        )
    }
}
