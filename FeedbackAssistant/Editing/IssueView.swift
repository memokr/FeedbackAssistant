//
//  IssueView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 07/10/24.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    @State private var showingNotificationError = false
    @Environment(\.openURL) var openUrl

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter the issue title here"))
                        .font(.title)

                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")

                    Text("**Status:** \(issue.issueStatus)")
                        .foregroundStyle(.secondary)
                }
                Picker("Priority", selection: $issue.priority) {
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }

                TagsMenuView(issue: issue)
            }

            Section {
                VStack(alignment: .leading) {
                    Text("Basic Information")
                        .font(.title)
                        .foregroundStyle(.secondary)

                    TextField("Description",
                              text: $issue.issueContent,
                              prompt: Text("Enter the issue description here"),
                              axis: .vertical
                    )
                }
            }

            Section("Reminders") {
                Toggle("Show reminders", isOn: $issue.reminderEnabled.animation())

                if issue.reminderEnabled {
                    DatePicker(
                        "Reminder time",
                        selection: $issue.issueReminderTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }
        }
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar {
            IssueViewToolbar(issue: issue)
        }
        .alert("Oops!", isPresented: $showingNotificationError) {
            Button("Check Settings", action: showAppSettings)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("There was a problem setting your notifications. Please check your settings.")
        }
        .onChange(of: issue.reminderEnabled) {
            updateReminder()
        }
        .onChange(of: issue.reminderTime) {
            updateReminder()
        }
    }

    func showAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openNotificationSettingsURLString) else {
            return
        }

        openUrl(settingsURL)
    }

    func updateReminder() {
        dataController.removeReminders(for: issue)

        Task { @MainActor in
            if issue.reminderEnabled {
                let success = await dataController.addReminders(for: issue)

                if success == false {
                    issue.reminderEnabled = false
                    showingNotificationError = true
                }
            }
        }
    }
}

#Preview {
    IssueView(issue: .example)
}
