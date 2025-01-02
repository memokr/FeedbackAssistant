//
//  ComplexFeedbackAssistantWidget.swift
//  FeedbackAssistantWidgetExtension
//
//  Created by Guillermo Kramsky on 02/01/25.
//

import WidgetKit
import SwiftUI

struct ComplexProvider: TimelineProvider {
    func placeholder(in context: Context) -> ComplexEntry {
        ComplexEntry(date: Date.now, issues: [.example])
    }

    func getSnapshot(in context: Context, completion: @escaping (ComplexEntry) -> ()) {
        let entry = ComplexEntry(date: Date.now, issues: loadIssues())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ComplexEntry(date: Date.now, issues: loadIssues())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    func loadIssues() -> [Issue] {
        let dataController = DataController()
        let request = dataController.fetchRequestForTopIssues(count: 1)
        return dataController.results(for: request)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct ComplexEntry: TimelineEntry {
    let date: Date
    let issues: [Issue]
}

struct ComplexFeedbackAssistantWidgetEntryView : View {
    var entry: ComplexProvider.Entry

    var body: some View {
        VStack {
            Text("Up Next:")
                .font(.title)

            if let issue = entry.issues.first {
                Text(issue.issueTitle)
            } else {
                Text("No issues found.")
            }
        }
    }
}

struct ComplexFeedbackAssistantWidget: Widget {
    let kind: String = "FeedbackAssistantWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ComplexProvider()) { entry in
            if #available(iOS 17.0, *) {
                ComplexFeedbackAssistantWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ComplexFeedbackAssistantWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Up next")
        .description("Your #1 top priority issue.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    ComplexFeedbackAssistantWidget()
} timeline: {
    ComplexEntry(date: .now, issues: [.example])
    ComplexEntry(date: .now, issues: [.example])
}

