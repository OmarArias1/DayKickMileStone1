//
//  HabitDetailViewController.swift
//  Daykick
//
//  Screen 3 - Habit Detail. Shows one habit selected from the list.
//  Owner: Omar
//
//  Added to the project by Kevin Lim on 10/31/26 (Milestone 1).
//

import UIKit

class HabitDetailViewController: UIViewController {

    // Set by HabitListViewController before this screen is pushed
    var habit: Habit?

    let completedSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never

        guard let habit = habit else { return }
        title = habit.name

        // "Edit" button in the navigation bar -> Edit Habit
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )

        // Description card
        let descriptionCard = Theme.makeCardStack([
            Theme.makeFieldLabel("DESCRIPTION"),
            Theme.makeValueLabel(habit.details)
        ])

        // Stats card: one horizontal row per fact
        let statsCard = Theme.makeCardStack([
            makeRow(name: "Current streak", value: "🔥 \(habit.currentStreak) days"),
            makeRow(name: "Longest streak", value: "🏆 \(habit.longestStreak) days"),
            makeRow(name: "Morning routine", value: habit.isMorningRoutine ? "Yes" : "No")
        ])
        statsCard.spacing = 12

        // Completed-today row with a switch
        completedSwitch.isOn = habit.isCompletedToday
        completedSwitch.onTintColor = Theme.accentColor
        completedSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        let completedRow = makeRow(name: "Completed today", control: completedSwitch)
        let completedCard = Theme.makeCardStack([completedRow])

        // Main vertical stack
        let mainStack = UIStackView(arrangedSubviews: [descriptionCard, statsCard, completedCard])
        mainStack.axis = .vertical
        mainStack.spacing = Theme.spacing
        view.addSubview(mainStack)

        // Auto Layout: pin to the safe area
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        mainStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Theme.topMargin).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Theme.sideMargin).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Theme.sideMargin).isActive = true
    }

    // Horizontal row: name on the left, value on the right
    func makeRow(name: String, value: String) -> UIStackView {
        let valueLabel = Theme.makeValueLabel(value)
        valueLabel.font = Theme.headingFont
        return makeRow(name: name, control: valueLabel)
    }

    func makeRow(name: String, control: UIView) -> UIStackView {
        let nameLabel = Theme.makeValueLabel(name)

        let row = UIStackView(arrangedSubviews: [nameLabel, control])
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 10
        row.distribution = .fill

        // Name label stretches; the value/control keeps its intrinsic size
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        control.setContentHuggingPriority(.required, for: .horizontal)
        return row
    }

    @objc func switchChanged() {
        // Milestone 1: UI only. Saving the completion comes in Milestone 3.
        print("Completed today: \(completedSwitch.isOn)")
    }

    // Habit Detail -> Edit Habit (same screen as Add, with the habit passed in)
    @objc func editButtonTapped() {
        let editVC = AddEditHabitViewController()
        editVC.habit = habit
        let navController = UINavigationController(rootViewController: editVC)
        present(navController, animated: true)
    }
}
