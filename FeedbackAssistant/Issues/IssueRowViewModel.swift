//
//  IssueRowViewModel.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 22/11/24.
//

import Foundation

extension IssueRow {
    class ViewModel: ObservableObject {

        let issue: Issue

        var iconOpacity: Double {
            issue.priority == 2 ? 1 : 0
        }

        var iconIdentifier: String {
            issue.priority == 2 ? "\(issue.issueTitle) High Priority" : ""
        }

        var creationDate: Date {
            issue.creationDate ?? .now
        }

        var accessibilityCreationDate: String {
            creationDate.formatted(date: .abbreviated, time: .omitted)
        }

        init(issue: Issue) {
            self.issue = issue
        }

    }
}
