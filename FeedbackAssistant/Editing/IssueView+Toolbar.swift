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
        #if !os(watchOS)
        Menu {
            Button("Copy Issue Title", systemImage: "doc.on.doc", action: copyToCLipboard)

            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(isIssueCompleted, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            #if !os(visionOS)
            .sensoryFeedback(trigger: issue.completed) { oldValue, newValue in
                if newValue {
                    .success
                } else {
                    nil
                }
            }
            #endif
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
        #endif
    }

    func copyToCLipboard() {
        #if os(iOS)
        UIPasteboard.general.string = issue.title
        #elseif os(macOS)
        NSPasteboard.general.prepareForNewContents()
        NSPasteboard.general.setString(issue.issueTitle, forType: .string)
        #endif
    }
}
