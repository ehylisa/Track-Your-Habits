//
//  Habit.swift
//  HabitTracker
//

import Foundation

struct Habit: Identifiable {
    let id: UUID
    let name: String
    let createdAt: Date

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
    }
}
