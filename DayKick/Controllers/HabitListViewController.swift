//
//  HabitListViewController.swift
//  Daykick
//
//  Screen 2 - Habit List. Shows every habit in a UITableView.
//  Owner: Kevin
//
//  Created by Kevin Lim on 10/31/26 (Milestone 1).
//

import UIKit

class HabitListViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate {

    let habits = sampleHabits
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Habits"
        view.backgroundColor = .systemBackground

        // "+" button in the navigation bar -> Add Habit
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )

        // Create table view and pin it to the safe area with Auto Layout
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Set the delegated objects
        tableView.dataSource = self
        tableView.delegate = self

        // Register reusable cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HabitCell")
    }

    // MARK: - UITableViewDataSource

    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }

    // Create/configure each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
        let habit = habits[indexPath.row]

        let check = habit.isCompletedToday ? "✅" : "⬜️"
        cell.textLabel?.text = "\(check)  \(habit.name)   🔥 \(habit.currentStreak)"
        cell.textLabel?.font = Theme.bodyFont
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // MARK: - UITableViewDelegate

    // Row tapped: Habit List -> Habit Detail
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = HabitDetailViewController()
        detailVC.habit = habits[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // Habit List -> Add Habit (present modally)
    @objc func addButtonTapped() {
        let addVC = AddEditHabitViewController()
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }
}
