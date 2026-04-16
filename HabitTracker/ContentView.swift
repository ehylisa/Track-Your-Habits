//
//  ContentView.swift
//  HabitTracker
//
//  Created by Lisa Yi on 2026-04-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var store = HabitStore()
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(Date.now, format: .dateTime.weekday(.wide).month(.wide).day())
                    .font(.custom("Roboto-Regular", size: 14))
                    .foregroundStyle(Color.tokenText.opacity(0.5))
                    .padding(.horizontal)
                    .padding(.top, 4)
                    .padding(.bottom, 8)

                if !store.habits.isEmpty {
                    let completed = store.habits.filter { $0.isCompletedToday() }.count
                    let total = store.habits.count
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(completed) of \(total) completed today")
                            .font(.custom("Roboto-Regular", size: 13))
                            .foregroundStyle(Color.tokenText.opacity(0.45))
                        ProgressView(value: Double(completed), total: Double(total))
                            .tint(Color.tokenSuccess)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }

                Group {
                if store.habits.isEmpty {
                    Text("No habits yet. Tap + to start.")
                        .font(.custom("Roboto-Regular", size: 14))
                        .foregroundStyle(Color.tokenText.opacity(0.4))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach($store.habits, id: \.id) { $habit in
                            Button {
                                habit.toggleToday()
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: habit.isCompletedToday() ? "checkmark.circle.fill" : "circle")
                                        .font(.system(size: 24))
                                        .foregroundStyle(habit.isCompletedToday() ? Color.tokenSuccess : Color.tokenText.opacity(0.3))
                                    Text(habit.name)
                                        .font(.custom("Roboto-Regular", size: 16))
                                        .foregroundStyle(Color.tokenText)
                                    Spacer()
                                    let streak = habit.currentStreak()
                                    if streak > 0 {
                                        Text("🔥 \(streak)")
                                            .font(.custom("Roboto-Regular", size: 14))
                                            .foregroundStyle(Color.tokenText.opacity(0.4))
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete { indexSet in
                            store.habits.remove(atOffsets: indexSet)
                        }
                    }
                }
                }
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add habit")
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddHabitSheet { name in
                    store.habits.append(Habit(name: name))
                }
            }
        }
    }
}

struct AddHabitSheet: View {
    let onSave: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit name", text: $name)
                    .font(.custom("Roboto-Regular", size: 16))
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(name.trimmingCharacters(in: .whitespaces))
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

extension Color {
    static let tokenPrimary   = Color(hex: "#111111")
    static let tokenSecondary = Color(hex: "#8B5CF6")
    static let tokenSuccess   = Color(hex: "#16A34A")
    static let tokenWarning   = Color(hex: "#D97706")
    static let tokenDanger    = Color(hex: "#DC2626")
    static let tokenSurface   = Color(hex: "#FFFFFF")
    static let tokenText      = Color(hex: "#111827")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
