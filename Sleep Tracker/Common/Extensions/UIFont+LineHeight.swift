//
//  UIFont+LineHeight.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

extension UILabel {
    func setLineHeight(lineHeightRatio: CGFloat) {
           guard let text = self.text else { return }

           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.lineSpacing = self.font.pointSize * lineHeightRatio - self.font.lineHeight
           paragraphStyle.alignment = self.textAlignment

           let attributedString = NSMutableAttributedString(string: text)
           attributedString.addAttribute(.paragraphStyle,
                                         value: paragraphStyle,
                                         range: NSRange(location: 0, length: attributedString.length))

           self.attributedText = attributedString
       }
}
