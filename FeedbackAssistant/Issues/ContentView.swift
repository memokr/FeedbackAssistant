//
//  ContentView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 24/08/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel
    @State private var filterText: String = ""

    var body: some View {
        List(selection: $viewModel.dataController.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSeletedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $viewModel.dataController.filterText,
                    tokens: $viewModel.dataController.filterTokens,
                    suggestedTokens: .constant(viewModel.dataController.suggestedFilterTokens),
                prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
        .onAppear(perform: askForReview)
        .onOpenURL(perform: openUrl)
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }

    func openUrl(_ url: URL) {
        if url.absoluteString.contains("newIssue") {
            viewModel.dataController.newIssue()
        }
    }
}

#Preview {
    ContentView(dataController: .preview)
}
