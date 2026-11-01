//
//  RemindersViewController.swift
//  Daykick
//
//  Created by Omar Arias on 10/31/26 (Milestone 1).

import UIKit

class RemindersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reminders"
        view.backgroundColor = .systemBackground

        // style and show label
        let label = Theme.makeValueLabel("Reminders screen in development")
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        view.addSubview(label)

        // setting up label constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Theme.sideMargin),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Theme.sideMargin)
        ])
    }
}
