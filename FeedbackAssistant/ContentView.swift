//
//  ContentView.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 24/08/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSeletedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $dataController.filterText,
                    tokens: $dataController.filterTokens,
                    suggestedTokens: .constant(dataController.suggestedFilterTokens),
                    prompt: "Filter issues, or type # to add tags"
        ) { tag in
            Text(tag.tagName)
        }
        .toolbar(content: ContentViewToolbar.init)
    }
    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSeletedFilter()
        for offset in offsets {
            let item = issues[offset]
            dataController.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
