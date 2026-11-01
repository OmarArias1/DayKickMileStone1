//
//  HomeViewController.swift
//  Daykick
//
//  Screen 1 - Home. Entry point: today's summary + navigation buttons.
//  Owner: Kevin
//
//  Created by Kevin Lim on 10/31/26 (Milestone 1).
//

import UIKit

class HomeViewController: UIViewController {

    let greetingLabel = UILabel()
    let summaryLabel = UILabel()
    let streakLabel = UILabel()
    let habitsButton = Theme.makePrimaryButton(title: "My Habits")
    let addButton = Theme.makeSecondaryButton(title: "Add Habit")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Daykick"
        view.backgroundColor = .systemBackground

        configureLabels()
        layoutViews()

        // Target-Action design pattern
        habitsButton.addTarget(self, action: #selector(habitsButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    func configureLabels() {
        let completed = sampleHabits.filter { $0.isCompletedToday }.count
        let bestStreak = sampleHabits.map { $0.currentStreak }.max() ?? 0

        greetingLabel.text = "Good morning!"
        greetingLabel.font = Theme.titleFont

        summaryLabel.text = "\(completed) of \(sampleHabits.count) habits done today"
        summaryLabel.font = Theme.headingFont

        streakLabel.text = "🔥 Best current streak: \(bestStreak) days"
        streakLabel.font = Theme.bodyFont
        streakLabel.textColor = .secondaryLabel
    }

    func layoutViews() {
        // Summary "card": vertical stack with padding and a background
        let summaryCard = Theme.makeCardStack([
            Theme.makeFieldLabel("TODAY"),
            summaryLabel,
            streakLabel
        ])

        // Buttons grouped in their own stack
        let buttonStack = UIStackView(arrangedSubviews: [habitsButton, addButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = Theme.spacing
        buttonStack.distribution = .fillEqually

        // Main vertical stack for the whole screen
        let mainStack = UIStackView(arrangedSubviews: [greetingLabel, summaryCard, buttonStack])
        mainStack.axis = .vertical
        mainStack.spacing = 24
        view.addSubview(mainStack)

        // Auto Layout: pin to the safe area (no fixed frames)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Theme.topMargin).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Theme.sideMargin).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Theme.sideMargin).isActive = true
    }

    // Home -> Habit List (push onto the navigation stack)
    @objc func habitsButtonTapped() {
        let listVC = HabitListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }

    // Home -> Add Habit (present modally)
    @objc func addButtonTapped() {
        let addVC = AddEditHabitViewController()   // habit stays nil = "add" mode
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }
}
