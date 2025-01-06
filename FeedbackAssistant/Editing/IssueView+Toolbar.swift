//
//  IssueViewToolbar.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 21/10/24.
//

import SwiftUI

struct IssueViewToolbar: View {
    @ObservedObject var issue: Issue
    @EnvironmentObject var dataController: DataController

    var isIssueCompleted: String {
        issue.completed ? "Re-open Issue" : "Close Issue"
    }

    var body: some View {
        Menu {
            Button("Copy Issue Title", systemImage: "doc.on.doc", action: copyToCLipboard)

            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(isIssueCompleted, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            .sensoryFeedback(trigger: issue.completed) { oldValue, newValue in
                if newValue {
                    .success
                } else {
                    nil
                }
            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }

    func copyToCLipboard() {
        #if os(iOS)
        UIPasteboard.general.string = issue.title
        #else
        NSPasteboard.general.prepareForNewContents()
        NSPasteboard.general.setString(issue.issueTitle, forType: .string)
        #endif
    }
}
