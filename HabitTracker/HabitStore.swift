//
//  HabitStore.swift
//  HabitTracker
//

import Combine
import Foundation

final class HabitStore: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet { save() }
    }

    private let fileURL: URL = {
        URL.documentsDirectory.appending(path: "habits.json")
    }()

    init() {
        load()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(habits) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
