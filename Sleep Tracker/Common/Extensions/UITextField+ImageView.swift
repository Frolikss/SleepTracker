//
//  UITextField+ImageView.swift
//  Sleep Tracker
//
//  Created by Dima Y on 21.02.2024.
//

import UIKit

extension UITextField {
    func setupRightImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 24, height: 24))
        imageView.image = UIImage(named: imageName)

        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)

        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }

    func removeRightImage() {
          rightView = nil
          rightViewMode = .never
    }
}
