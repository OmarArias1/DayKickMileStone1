//
//  Theme.swift
//  Daykick
//
//  One place for colors, fonts, spacing and reusable controls so every
//  screen looks the same.
//
//  SHARED FILE
//
//  Added by Kevin Lim on 10/31/26 (Milestone 1).
//

import UIKit

enum Theme {

    // Colors
    static let accentColor = UIColor.systemOrange
    static let cardColor = UIColor.secondarySystemBackground

    // Fonts
    static let titleFont = UIFont.systemFont(ofSize: 28, weight: .bold)
    static let headingFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let bodyFont = UIFont.systemFont(ofSize: 17)
    static let captionFont = UIFont.systemFont(ofSize: 14)

    // Spacing
    static let sideMargin: CGFloat = 20
    static let topMargin: CGFloat = 20
    static let spacing: CGFloat = 16
    static let smallSpacing: CGFloat = 6
    static let cornerRadius: CGFloat = 10
    static let buttonHeight: CGFloat = 50

    // Filled orange button for the main action on a screen
    static func makePrimaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = headingFont
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = accentColor
        button.layer.cornerRadius = cornerRadius
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        return button
    }

    // Outlined button for secondary actions
    static func makeSecondaryButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = headingFont
        button.setTitleColor(accentColor, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = 1.5
        button.layer.borderColor = accentColor.cgColor
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        return button
    }

    // Small gray label used above form fields / as a row name
    static func makeFieldLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = captionFont
        label.textColor = .secondaryLabel
        return label
    }

    // Normal text label for values
    static func makeValueLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = bodyFont
        label.numberOfLines = 0
        return label
    }

    // Vertical stack with padding and a rounded background ("card")
    static func makeCardStack(_ views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.spacing = smallSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.backgroundColor = cardColor
        stack.layer.cornerRadius = cornerRadius
        return stack
    }
}
