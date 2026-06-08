//
//  ContentView.swift
//  TimePickerDemo
//
//  Created by Quien on 2026-06-08.
//

import SwiftUI
import TimePicker

struct ContentView: View {
  enum Accent: String, CaseIterable, Identifiable {
    case primary = "Default"
    case orange = "Orange"
    case blue = "Blue"
    case pink = "Pink"
    var id: Self { self }

    var color: Color {
      switch self {
      case .primary: .primary
      case .orange: .orange
      case .blue: .blue
      case .pink: .pink
      }
    }
  }

  @State private var finishTime: TimeInterval? = 3 * 3600 + 20 * 60 + 44
  @State private var lapTime: TimeInterval?
  @State private var reminder: TimeInterval? = 90 * 60
  @State private var labeled: TimeInterval? = 25 * 60
  @State private var accent: Accent = .orange

  var body: some View {
    NavigationStack {
      Form {
        Section("Style") {
          Picker("Accent", selection: $accent) {
            ForEach(Accent.allCases) { Text($0.rawValue).tag($0) }
          }
          .pickerStyle(.segmented)
        }

        Section("Hours · Minutes · Seconds") {
          TimePicker("Finish Time", selection: $finishTime)
          Text(summary(finishTime))
            .font(.footnote)
            .foregroundStyle(.secondary)
        }

        Section("Minutes · Seconds") {
          TimePicker("Lap Time", components: .minutesSeconds, selection: $lapTime)
          Text(summary(lapTime))
            .font(.footnote)
            .foregroundStyle(.secondary)
        }

        Section("Hours · Minutes — capped at 12h") {
          TimePicker(
            "Reminder",
            components: .hoursMinutes,
            maximumHours: 12,
            selection: $reminder
          )
          Text(summary(reminder))
            .font(.footnote)
            .foregroundStyle(.secondary)
        }

        Section("Custom Label") {
          TimePicker(components: .minutesSeconds, selection: $labeled) {
            Label("Focus Session", systemImage: "timer")
          }
          Text(summary(labeled))
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
      }
      .navigationTitle("TimePicker Demo")
      .timePickerStyle(accentColor: accent.color)
    }
  }

  // MARK: - Helpers
  private func summary(_ value: TimeInterval?) -> String {
    guard let value else { return "No value selected" }
    let total = Int(value)
    let hours = total / 3600
    let minutes = (total % 3600) / 60
    let seconds = total % 60
    return "Bound value: \(total)s  (\(hours)h \(minutes)m \(seconds)s)"
  }
}

#Preview {
  ContentView()
}
