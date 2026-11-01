//
//  HistoryViewController.swift
//  Daykick
//
//  Created by Omar Arias on 10/31/26 (Milestone 1).

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        view.backgroundColor = .systemBackground

        // style and show label
        let label = Theme.makeValueLabel("History Screen in development")
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        view.addSubview(label)

        // set up constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Theme.sideMargin),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Theme.sideMargin)
        ])
    }
}
