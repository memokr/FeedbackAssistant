//
//  IssueRow.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 07/10/24.
//

import SwiftUI

struct IssueRow: View {
    @EnvironmentObject var dataContoller: DataController
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationLink(value: viewModel.issue) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(viewModel.iconOpacity)
                    .accessibilityIdentifier(viewModel.iconIdentifier)

                VStack(alignment: .leading) {
                    Text(viewModel.issue.issueTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(viewModel.issue.issueTagsList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewModel.creationDate.formatted(date: .numeric, time: .omitted))
                        .accessibilityLabel(viewModel.accessibilityCreationDate)
                        .font(.subheadline)

                    if viewModel.issue.completed {
                        Text("Closed")
                            .font(.body.smallCaps())
                    }
                }
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityHint(viewModel.issue.priority == 2 ? "High priority" : "")
        .accessibilityIdentifier(viewModel.issue.issueTitle)
    }

    init(issue: Issue) {
        let viewModel = ViewModel(issue: issue)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

#Preview {
    IssueRow(issue: .example)
}
