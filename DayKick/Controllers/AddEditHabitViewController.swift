//
//  AddEditHabitViewController.swift
//  Daykick
//
//  Screen 4 - Add / Edit Habit. One form used for both:
//    habit == nil  -> "New Habit"
//    habit != nil  -> "Edit Habit" (fields pre-filled)
//  Owner: Omar
//
//  Added to the project by Kevin Lim on 10/31/26 (Milestone 1).
//

import UIKit

class AddEditHabitViewController: UIViewController, UITextFieldDelegate {

    // nil = add a new habit, otherwise edit this habit
    var habit: Habit?

    let nameField = UITextField()
    let detailsTextView = UITextView()
    let startControl = UISegmentedControl(items: ["Today", "Tomorrow"])
    let morningSwitch = UISwitch()
    let saveButton = Theme.makePrimaryButton(title: "Save Habit")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = (habit == nil) ? "New Habit" : "Edit Habit"
        navigationItem.largeTitleDisplayMode = .never

        // "Cancel" in the navigation bar closes the modal screen
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )

        configureControls()
        layoutForm()

        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    func configureControls() {
        nameField.placeholder = "e.g. Drink water"
        nameField.borderStyle = .roundedRect
        nameField.font = Theme.bodyFont
        nameField.returnKeyType = .done
        nameField.delegate = self                      // Delegate design pattern

        detailsTextView.font = Theme.bodyFont
        detailsTextView.layer.borderWidth = 1
        detailsTextView.layer.borderColor = UIColor.systemGray4.cgColor
        detailsTextView.layer.cornerRadius = 6
        detailsTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        startControl.selectedSegmentIndex = 0
        startControl.selectedSegmentTintColor = Theme.accentColor

        morningSwitch.onTintColor = Theme.accentColor

        // Edit mode: pre-fill the form with the selected habit
        if let habit = habit {
            nameField.text = habit.name
            detailsTextView.text = habit.details
            morningSwitch.isOn = habit.isMorningRoutine
        }
    }

    func layoutForm() {
        // Each field = small vertical stack (label above the control)
        let nameGroup = makeFieldGroup(title: "NAME", control: nameField)
        let detailsGroup = makeFieldGroup(title: "DESCRIPTION", control: detailsTextView)
        let startGroup = makeFieldGroup(title: "START", control: startControl)

        // Start date only applies to new habits; hidden views collapse inside a stack view
        startGroup.isHidden = (habit != nil)

        // Switch row = horizontal stack
        let morningLabel = Theme.makeValueLabel("Part of my morning routine")
        let morningRow = UIStackView(arrangedSubviews: [morningLabel, morningSwitch])
        morningRow.axis = .horizontal
        morningRow.alignment = .center
        morningRow.spacing = 10
        morningLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        morningSwitch.setContentHuggingPriority(.required, for: .horizontal)

        // Form = vertical stack of all groups + Save button
        let formStack = UIStackView(arrangedSubviews: [nameGroup, detailsGroup, startGroup, morningRow, saveButton])
        formStack.axis = .vertical
        formStack.spacing = 20
        formStack.setCustomSpacing(32, after: morningRow)
        view.addSubview(formStack)

        // Auto Layout: pin to the safe area
        formStack.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        formStack.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Theme.topMargin).isActive = true
        formStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Theme.sideMargin).isActive = true
        formStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Theme.sideMargin).isActive = true
    }

    func makeFieldGroup(title: String, control: UIView) -> UIStackView {
        let group = UIStackView(arrangedSubviews: [Theme.makeFieldLabel(title), control])
        group.axis = .vertical
        group.spacing = Theme.smallSpacing
        return group
    }

    // MARK: - UITextFieldDelegate

    // Hide the keyboard when "Done" is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Actions

    @objc func saveTapped() {
        // Milestone 1: no permanent storage required.
        let name = nameField.text ?? ""
        print("Save tapped - name: \(name), morning routine: \(morningSwitch.isOn)")
        dismiss(animated: true)
    }

    @objc func cancelTapped() {
        dismiss(animated: true)
    }
}
