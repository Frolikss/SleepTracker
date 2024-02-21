//
//  TextField.swift
//  Sleep Tracker
//
//  Created by Dima Y on 13.02.2024.
//

import UIKit

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
