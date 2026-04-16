//
//  Habit.swift
//  HabitTracker
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    let name: String
    let createdAt: Date
    var completedDates: Set<String>

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.completedDates = []
    }

    func isCompletedToday() -> Bool {
        completedDates.contains(Self.dateString(for: .now))
    }

    func currentStreak() -> Int {
        let calendar = Calendar.current
        let startDate = isCompletedToday() ? .now : calendar.date(byAdding: .day, value: -1, to: .now)!
        var streak = 0
        var date = startDate
        while completedDates.contains(Self.dateString(for: date)) {
            streak += 1
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        return streak
    }

    mutating func toggleToday() {
        let today = Self.dateString(for: .now)
        if completedDates.contains(today) {
            completedDates.remove(today)
        } else {
            completedDates.insert(today)
        }
    }

    private static func dateString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date)
    }
}
