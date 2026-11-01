//
//  Habit.swift
//  Daykick
//
//  Model layer (MVC). Hard-coded sample data is allowed for Milestone 1.
//
//  SHARED FILE
//
//  Added by Kevin Lim on 10/31/26 (Milestone 1). Changed sample habit "Journal" to "Gym".
//

import Foundation

struct Habit {
    var name: String
    var details: String
    var currentStreak: Int
    var longestStreak: Int
    var isCompletedToday: Bool
    var isMorningRoutine: Bool
}

let sampleHabits = [
    Habit(name: "Drink water", details: "Drink a full glass of water right after waking up.",
          currentStreak: 5, longestStreak: 12, isCompletedToday: true, isMorningRoutine: true),
    Habit(name: "Read", details: "Read at least 20 minutes of a book.",
          currentStreak: 2, longestStreak: 9, isCompletedToday: false, isMorningRoutine: false),
    Habit(name: "Stretch", details: "10-minute morning stretch.",
          currentStreak: 0, longestStreak: 4, isCompletedToday: false, isMorningRoutine: true),
    Habit(name: "Make bed", details: "Make the bed before leaving the room.",
          currentStreak: 14, longestStreak: 14, isCompletedToday: true, isMorningRoutine: true),
    Habit(name: "Gym", details: "Work out at the gym for at least 45 minutes.",
          currentStreak: 1, longestStreak: 6, isCompletedToday: false, isMorningRoutine: false)
]
