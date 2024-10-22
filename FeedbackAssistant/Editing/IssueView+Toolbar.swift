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
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }

            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(isIssueCompleted, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }
}
